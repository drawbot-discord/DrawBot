module DrawBot
  # Error to raise when CannedResponse is improperly configured
  class CannedResponseError < Exception
  end

  # This loads multiple newline-deliminated text file inputs and each
  # time the middleware is called, it places random samples according to a
  # provided string "template" and sends it back to Discord.
  #
  # The template syntax is based off of the filename:
  # ```
  # # With a single file:
  # CannedResponse.new("name.txt", template: "Hello $name, I'm $name")
  #
  # # With multiple sources:
  # CannedResponse.new(
  #   "name.txt", "location.txt",
  #   template: "Hello $name, I am $name from $location")
  # ```
  # Where `name.txt` is a plain text file with a single name on each line.
  #
  # Each `$name` will be replaced by a random line from the text file. The
  # middleware ensures the same sample isn't used more than once per message,
  # per file.
  #
  # A check is performed when the middleware is initialized that the template
  # string does not try to sample from a data source more times than it has
  # data to provide.
  # ```
  # CannedResponse.new({"foo" => ["bar"]}, "$foo $foo $foo")
  # # => Raises CannedResponseError because "foo" only has one entry,
  # #    and three unique samples cannot be generated
  # ```
  #
  # There are two special reserved patterns in string templates:
  #   - `$content` is replaced by `context.arguments[0]` for chaining with `SplitParser`
  #   - `$author` is replaced by the name of the original message author
  #
  # ```
  # client.on_message_create(
  #   SplitParser.new("~name", join_after: 1),
  #   CannedResponse.new("name.txt", "hello $name, $author says $content"))
  #
  # # The command "~name wuzzup" now replies:
  # # "hello dennis, zac says wuzzup"
  # ```
  #
  # NOTE: This middleware always passes to the rest of the chain.
  class CannedResponse
    include DiscordMiddleware::CachedRoutes

    @sources = {} of String => Array(String)

    def initialize(@sources : Hash(String, Array(String)), @template : String)
      validate_template
    end

    def initialize(*filenames : String, @template : String)
      filenames.each do |path|
        key = File.basename(path, ".txt")
        data = File.read_lines(path)
        @sources[key] = data
      end
      validate_template
    end

    # :nodoc:
    def validate_template
      @sources.each do |key, data|
        uses = 0
        @template.scan(/\$\w+/) do |word|
          uses += 1 if word[0] == "$#{key}"
        end

        if uses > data.size
          raise CannedResponseError.new("Template invokes $#{key} more times than its data pool can provide! #{uses} / #{data.size}")
        end
      end
    end

    # :nodoc:
    def produce_response(content = nil, author = nil)
      reader = Char::Reader.new(@template)
      used = {} of String => Set(String)
      String.build do |str|
        while reader.has_next?
          case reader.current_char
          when '$'
            start = reader.pos + 1
            while reader.has_next? && reader.next_char.letter?
              # Nothing to do
            end
            key = @template[start..reader.pos - 1]
            case key
            when "content"
              str << content if content
            when "author"
              str << author if author
            else
              used[key] ||= Set(String).new
              while true
                sample = @sources[key].sample
                next if used[key].includes?(sample)
                used[key].add sample
                str << sample
                break
              end
            end
          else
            str << reader.current_char
            reader.next_char
          end
        end
      end
    end

    def call(payload, context)
      client = context[Discord::Client]
      display_name = context.payload.author.username

      if guild_id = get_channel(client, payload.channel_id).guild_id
        member = get_member(client, guild_id, payload.author.id)
        display_name = member.nick || display_name
      end

      response = produce_response(context.arguments[0]?, display_name)
      context.client.create_message(
        context.payload.channel_id,
        response
      )
      yield
    end
  end
end

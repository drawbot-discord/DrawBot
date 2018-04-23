module DrawBot
  # Basic command string parser. Example usage:
  # ```
  # client.on_message_create(
  #   DiscordMiddleware::Error.new("`%exception%`"),
  #   SplitParser.new("~add", min_args: 2, max_args: 2)) do |payload, ctx|
  #   arguments = ctx[SplitParser::Results].arguments
  #   a, b = arguments.map &.to_i
  #   client.create_message(
  #     payload.channel_id,
  #     "#{a} + #{b} = #{a + b}"
  #   )
  # end
  # ```
  class SplitParser
    # Results of the parsing operation
    class Results
      getter arguments

      def initialize(@arguments : Array(String))
      end
    end

    @command_name : String

    def initialize(command_name : String, @min_args : Int32? = nil,
                   @max_args : Int32? = nil, @join_after : Int32? = nil)
      @command_name = command_name.downcase
    end

    def call(payload, context)
      return if payload.content.empty?
      client = context[Discord::Client]
      args = payload.content.split(
        ' ',
        limit: @join_after.try { |v| v + 1 },
        remove_empty: true)
      return unless args[0].downcase == @command_name

      given = args.size - 1

      if min = @min_args
        if given < min
          client.create_message(
            payload.channel_id,
            "Too few arguments for `#{@command_name}`. (#{given} given, minimum: #{min})"
          )
          return
        end
      end

      if max = @max_args
        if given > max
          client.create_message(
            payload.channel_id,
            "Too many arguments for `#{@command_name}`. (#{given} given, maximum: #{max})"
          )
          return
        end
      end

      context.put Results.new(args[1..-1])
      yield
    end
  end
end

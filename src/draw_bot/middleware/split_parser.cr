module DrawBot
  # Add Context#arguments
  Discord.add_ctx_property! arguments, Array(String)

  # Basic command string parser. Example usage:
  # ```
  # client.on_message_create(
  #   DiscordMiddleware::Error.new("`%exception%`"),
  #   SplitParser.new("~add", min_args: 2, max_args: 2)) do |ctx|
  #   a, b = ctx.arguments.map &.to_i
  #   ctx.client.create_message(
  #     ctx.payload.channel_id,
  #     "#{a} + #{b} = #{a + b}"
  #   )
  # end
  # ```
  class SplitParser < Discord::Middleware
    def initialize(@command_name : String, @min_args : Int32? = nil,
                   @max_args : Int32? = nil, @join_after : Int32? = nil)
    end

    def call(context : Discord::Context(Discord::Message), done)
      return unless context.payload.content.starts_with?(@command_name)
      args = context.payload.content.split(
        ' ',
        limit: @join_after.try { |v| v + 1 },
        remove_empty: true)

      given = args.size - 1

      if min = @min_args
        if given < min
          context.client.create_message(
            context.payload.channel_id,
            "Too few arguments for `#{@command_name}`. (#{given} given, minimum: #{min})"
          )
          return
        end
      end

      if max = @max_args
        if given > max
          context.client.create_message(
            context.payload.channel_id,
            "Too many arguments for `#{@command_name}`. (#{given} given, maximum: #{max})"
          )
          return
        end
      end

      context.arguments = args[1..-1]
      done.call
    end
  end
end

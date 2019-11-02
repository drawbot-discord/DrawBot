module DrawBot
  # Middleware for checking the names of the roles the bot itself has
  # in an invoking guild. It must have at least one of the roles to pass.
  # The user will be presented with an error message
  # if the bot does not have any of the listed roles.
  # ```
  # client.on_message_create(RoleNameGuard.new("nsfw", "noclip")) do |payload, ctx|
  #   client.create_message(payload.channel_id, "I have the nsfw or noclip role!")
  # end
  # ```
  class RoleNameGuard
    include DiscordMiddleware::CachedRoutes

    @response : String
    @role_names = [] of String

    def initialize(*role_names : String)
      role_names.each { |name| @role_names << name }
      @response = build_response(@role_names)
    end

    private def roles_in(client, payload)
      results = [] of String
      if guild_id = get_channel(client, payload.channel_id).guild_id
        member = get_member(client, guild_id, Discord::Snowflake.new(DrawBot.config.client_id))
        get_guild(client, guild_id).roles.each do |role|
          results << role.name if member.roles.any? { |id| id == role.id }
        end
      end
      results
    end

    # :nodoc:
    def build_response(role_names)
      String.build do |str|
        str << "I need "
        case role_names.size
        when 1
          str << "the `" << role_names[0] << "` role "
        when 2
          str << "the `" << role_names[0] << "` or `" << role_names[1] << "` role "
        when .> 2
          str << "one of the "
          role_names[0..1].each { |name| str << "`" << name << "`, " }
          str << "or `" << role_names.last << "` roles "
        end
        str << "to use this command!"
      end
    end

    def call(payload, context)
      roles = roles_in(context[Discord::Client], payload)
      if @role_names.any? { |r| roles.includes?(r) }
        yield
      else
        context[Discord::Client].create_message(
          payload.channel_id,
          @response
        )
      end
    end
  end
end

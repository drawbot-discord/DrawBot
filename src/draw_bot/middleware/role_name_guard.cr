module DrawBot
  # Middleware for checking the names of the roles the bot itself has
  # in an invoking guild. It must have at least one of the roles to pass.
  # The user will be presented with an error message
  # if the bot does not have any of the listed roles.
  # ```
  # client.on_message_create(RoleNameGuard.new("nsfw", "noclip")) do |ctx|
  #   client.create_message(ctx.payload.channel_id, "I have the nsfw or noclip role!")
  # end
  # ```
  class RoleNameGuard < Discord::Middleware
    include DiscordMiddleware::CachedRoutes

    @response : String
    @role_names = [] of String

    def initialize(*role_names : String)
      role_names.each { |name| @role_names << name }
      @response = build_response(@role_names)
    end

    # :nodoc:
    def roles_in(context)
      results = [] of String
      if guild_id = get_channel(context.client, context.payload.channel_id).guild_id
        member = get_member(context.client, guild_id, DrawBot.config.client_id)
        get_guild(context.client, guild_id).roles.each do |role|
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

    def call(context : Discord::Context(Discord::Message), done)
      roles = roles_in(context)
      if @role_names.any? { |r| roles.includes?(r) }
        done.call
      else
        context.client.create_message(
          context.payload.channel_id,
          @response
        )
      end
    end
  end
end

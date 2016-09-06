module DrawBot
  module Database
    # Represents a Discord server.
    class Server < Sequel::Model
      # Sets up model before creation
      def before_create
        super
        self.timestamp ||= Time.now
      end

      # Log successful creation
      def after_create
        Discordrb::LOGGER.info "created server: #{inspect}"
      end

      # Fetches Discord member of the owner from cache
      # @return [Discordrb::Member] the server owner
      def owner
        BOT.server(discord_id).member(owner_id)
      end
    end
  end
end

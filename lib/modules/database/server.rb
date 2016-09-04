module DrawBot
  module Database
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

      # Fetches Discord user of the owner from cache
      # @return [Discordrb::User] the server owner
      def owner
        BOT.user(owner_id)
      end
    end
  end
end

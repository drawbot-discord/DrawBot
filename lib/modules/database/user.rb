module DrawBot
  module Database
    # Represents a Discord user
    class User < Sequel::Model
      one_to_one :bank

      # Sets up model before creation
      def before_create
        super
        self.timestamp ||= Time.now
      end

      # Logs successful User creation
      def after_create
        Discordrb::LOGGER.info "created user: #{inspect}"
      end

      # Fetches Discord user from cache
      def user
        BOT.user(discord_id)
      end
    end
  end
end

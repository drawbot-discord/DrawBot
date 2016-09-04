module DrawBot
  module Database
    class Transaction < Sequel::Model
      many_to_one :bank
      many_to_one :user

      # Set up model before creation
      def before_create
        super
        self.timestamp ||= Time.now
      end

      # Log successful creation
      def after_create
        Discordrb::LOGGER.info "created transaction: #{inspect}"
      end
    end
  end
end

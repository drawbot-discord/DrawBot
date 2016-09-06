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
        super
        Discordrb::LOGGER.info "created transaction: #{inspect}"
        bank.stipend -= amount
        bank.save
        user.update_bank
      end
    end
  end
end

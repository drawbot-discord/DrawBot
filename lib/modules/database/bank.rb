module DrawBot
  module Database
    class Bank < Sequel::Model
      many_to_one :user
      one_to_many :transactions

      # Log successful creation
      def after_create
        Discordrb::LOGGER.info "created bank account: #{inspect}"
      end
    end
  end
end

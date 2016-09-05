module DrawBot
  module Database
    class Bank < Sequel::Model
      many_to_one :user
      one_to_many :transactions

      # Log successful creation
      def after_create
        Discordrb::LOGGER.info "created bank account: #{inspect}"
      end

      # Bank stats
      def stats
        total = hearts + salt
        percent_hearts = ((hearts.to_f / total.to_f) * 100).round(2)
        percent_salt = ((salt.to_f / total.to_f) * 100).round(2)
        {
          total: total,
          hearts: hearts,
          salt: salt,
          stipend: stipend,
          percent_hearts: percent_hearts,
          percent_salt: percent_salt
        }
      end
    end
  end
end

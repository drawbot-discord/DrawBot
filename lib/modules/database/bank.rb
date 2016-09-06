module DrawBot
  module Database
    class Bank < Sequel::Model
      many_to_one :user
      one_to_many :transactions

      # Log successful creation
      def after_create
        Discordrb::LOGGER.info "created bank account: #{inspect}"
        user.update_bank
      end

      # Bank stats. This is primarily used to generate leaderboards.
      # @return [Hash]
      #   * :owner [String] owner of the account
      #   * :total [Integer] sum total of currency (hearts + salt)
      #   * :hearts [Integer] heart total
      #   * :salt [Integer] salt total
      #   * :stipend [Integer] stipend total
      #   * :percent_hearts [Float] percentage of user currency that is hearts
      #   * :percent_salt [Float] percentage of user currency that is salt
      def stats
        total = hearts + salt
        percent_hearts = ((hearts.to_f / total.to_f) * 100).round(2)
        percent_salt = ((salt.to_f / total.to_f) * 100).round(2)
        {
          owner: user.discord_name,
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

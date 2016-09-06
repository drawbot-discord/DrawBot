module DrawBot
  module DiscordCommands
    # Views a user's bank balance.
    module Bank
      extend Discordrb::Commands::CommandContainer
      command :bank do |event|
        user_sql = Database::User.find(discord_id: event.user.id)
        unless user_sql.nil?
          bank_sql = user_sql.bank
          unless bank_sql.nil?
            stats = bank_sql.stats
            event << "You are **#{stats[:percent_hearts]}%** lovely 😍 "\
                     "and **#{stats[:percent_salt]}%** salty 😡"
            event << "**Hearts:** #{stats[:hearts]} | "\
                     "**Salt:** #{stats[:salt]} | "\
                     "**Stipend:** #{stats[:stipend]}"
            return
          end
          event << 'You don\'t have a bank!\n'\
                   "Register one with `#{BOT.prefix}register`."
          return
        end
        'I don`t know you!'
      end
    end
  end
end

module DrawBot
  module DiscordCommands
    # Creates a bank account for the user.
    module Register
      extend Discordrb::Commands::CommandContainer
      command(:register,
              description: 'registers a bank account for a user',
              usage: "#{BOT.prefix}register") do |event|
        user_sql = Database::User.find(discord_id: event.user.id)
        unless user_sql.nil?
          if user_sql.bank.nil?
            Database::Bank.create(user: user_sql,
                                  stipend: CONFIG.stipend)
            event << "Thank you for registering a DrawBot™ Bank Account!\n"\
                     "Use #{BOT.prefix}bank to view your balance.\n"\
                     "User #{BOT.prefix}help give to learn how to trade"\
                     'with other registered users.'
          else
            event << 'You already have a DrawBot™ Bank Account!'
          end
          return
        end
        event << 'I don\'t know you!'
      end
    end
  end
end

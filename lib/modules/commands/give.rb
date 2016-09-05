module DrawBot
  module DiscordCommands
    # Gives currency to another user.
    module Give
      extend Discordrb::Commands::CommandContainer
      command(:give,
              description: 'Gives currency to another user, '\
                           'either `hearts` or `salt`',
              usage: "#{BOT.prefix}give @user amount hearts/salt",
              min_args: 3,
              max_args: 3) do |event, _mention, amount, kind|
        amount = amount.to_i
        kind = kind.downcase
        if event.message.mentions.empty?
          event << 'Please @mention a recipient.'
          return
        end
        sender_sql = Database::User.find(discord_id: event.user.id)
        recipient_sql = Database::User.find(discord_id: event.message
                                                             .mentions
                                                             .first
                                                             .id)
        unless sender_sql.nil? || recipient_sql.nil?
          sender_bank = sender_sql.bank
          unless sender_bank.nil?
            unless (sender_bank.stipend - amount) < 0
              unless amount < 1
                if %w(hearts salt).include? kind
                  Database::Transaction.create(bank: sender_bank,
                                               user: recipient_sql,
                                               amount: amount,
                                               kind: kind)
                  event << 'Transaction complete.'
                  return
                else
                  event << 'Please specify a valid kind: `hearts` or `salt`'
                  return
                end
              end
              event << 'Please specify a value greater than zero.'
              return
            end
            event << 'You don\'t have enough for this transaction..'
            return
          end
          event << 'You don\'t have a registered account.\n'\
                   "You can register with `#{BOT.prefix}register`."
          return
        end
        'I don\'t know you!'
      end
    end
  end
end

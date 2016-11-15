module DrawBot
  module DiscordCommands
    # Commands for server and bot administration
    module AdminCommands
      extend Discordrb::Commands::CommandContainer
      command(:restart,
              description: 'restarts the bot',
              usage: "#{BOT.prefix}restart") do |event|
        break unless event.channel.id == DEVCHANNEL
        event.channel.send_message("Restart issued.. :wrench:\n"\
                                   "I'll be back soon!")
        bot.stop
        exit
      end

      command(:bad,
              description: 'Softbans a user',
              usage: "#{BOT.prefix}bad") do |event, *message|
        break unless event.user.role? event.server.role { |r| %w(DBAdmin Moderator).include? r.name }
        unless event.message.mentions.nil?
          softban = event.server.roles.find { |r| r.name == 'softban' }
          event.message.mentions.first.on(event.server).roles = softban unless softban.nil?
        end
        message = message.join(' ')

        "#{event.user.display_name} throws #{message} into timeout."
      end
    end
  end
end

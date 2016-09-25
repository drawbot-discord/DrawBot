module DrawBot
  module DiscordCommands
    module AdminCommands
      bot.command(:restart,
                  description: 'restarts the bot',
                  usage: "#{BOT.prefix}restart") do |event|
       break unless event.channel.id == DEVCHANNEL
       event.channel.send_message("Restart issued.. :wrench:\n
                                          I'll be back soon!")
        bot.stop
       exit
      end

      bot.command(:bad
                   description: 'Softbans a user',
                   usage: "#{BOT.prefix}bad") do |event, *message|
        break unless event.user.role? event.server.role { |r| ['DBAdmin','Moderator'].include? r.name }
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

#Public/Utility commands
module DrawBot
  module DiscordCommands
    module UtilityCommands
     extend Discordrb::Commands::CommandContainer
     bot.command(:commands,
                 description: 'Lists the publicly available commands',
                 usage: "#{BOT.prefix}commands") do |event|
     'https://github.com/LeggoMyEcho/DrawBot/wiki/Commands'
     end

     bot.command(:restart,
                 description: "restarts the bot") do |event|
                 break unless event.channel.id == DEVCHANNEL
                 event.channel.send_message("Restart issued.. :wrench:")
                 bot.stop
                 exit
      end
    end
  end
end

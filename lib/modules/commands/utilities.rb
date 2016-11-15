#Public/Utility commands
module DrawBot
  module DiscordCommands
    module UtilityCommands
     bot.command(:commands,
                 description: 'Lists the publicly available commands',
                 usage: "#{BOT.prefix}commands") do |event|
     "https://github.com/LeggoMyEcho/DrawBot/wiki/Commands"
     end
    end
  end
end

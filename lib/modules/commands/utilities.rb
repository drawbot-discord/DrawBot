#Public/Utility commands
module DrawBot
  module DiscordCommands
    module UtilityCommands
     bot.command(:commands,
                 description: 'Lists the publicly available commands',
                 usage: "#{BOT.prefix}commands") do |event|
     "#{publiccommands.join("\n")}"
     end
    end
  end
end

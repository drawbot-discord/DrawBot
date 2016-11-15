#Public/Utility commands
module DrawBot
  module DiscordCommands
    module UtilityCommands
      extend Discordrb::Commands::CommandContainer
      command(:commands,
              description: 'Lists the publicly available commands',
              usage: "#{BOT.prefix}commands") do |event|
        'https://github.com/LeggoMyEcho/DrawBot/wiki/Commands'
      end

      command(:getdb, help_available: false) do |event|
        break unless event.channel.id == DEVCHANNEL
        file = File.open('db.yaml')
        event.channel.send_file(file)
      end
    end
  end
end

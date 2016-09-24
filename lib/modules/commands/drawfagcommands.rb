module DrawBot
  module DiscordCommands
    # Available Commands
    # - 'gimme'
    # - 'doit'
    module DrawFagCommands
      extend Discordrb::Commands::CommandContainer
      command(:gimme,
              usage: "#{BOT.prefix}gimme") do |event|
        break unless event.server.id == 175579371975868416
        'http://i.imgur.com/A9UWyst.png'
      end

      command(:doit,
              usage: "#{BOT.prefix}doit") do |event|
        break unless event.server.id == 175579371975868416
        'http://i.imgur.com/nFWku9b.jpg'
      end
    end
  end
end

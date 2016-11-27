require 'open-uri'

module DrawBot
  module DiscordCommands
    # Gives you a random cat!
    module Cat
      extend Discordrb::Commands::CommandContainer
      command(:cat,
              description: 'Gives you a random cat!',
              usage: "#{BOT.prefix}cat") do |event|
                catlink = JSON.parse(open('http://random.cat/meow').read)
          event <<  "Meow! #{catlink['file'].gsub('.jpg', '')}"
        end
      end
    end
  end
end

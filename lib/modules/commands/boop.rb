module DrawBot
  module DiscordCommands
    # Boops someone, or something
    module Boop
      extend Discordrb::Commands::CommandContainer
      command(:boop,
              description: 'Boops someone or something',
              usage: "#{BOT.prefix}boop something") do |event, *thing|
        thing = thing.join(' ')
        response = Database::Response.where(key: 'boop').all.sample.response
        "#{event.user.display_name} #{response} boops #{thing}"
      end
    end
  end
end

module DrawBot
  module DiscordCommands
    # Gives you a random pun!
    module Pun
      extend Discordrb::Commands::CommandContainer
      command(:pun,
              description: 'Gives you a random pun!',
              usage: "#{BOT.prefix}pun") do |_event|
        Database::Response.where(key: 'pun').all.sample.response
      end
    end
  end
end

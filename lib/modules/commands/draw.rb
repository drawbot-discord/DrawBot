module DrawBot
  module DiscordCommands
    # Gives you a random idea of what to draw!
    module Draw
      extend Discordrb::Commands::CommandContainer
      command(:draw,
              description: 'Gives you a random idea of what to draw!',
              usage: "#{BOT.prefix}draw") do |_event|
        thing = Database::Response.where(key: 'draw').all.sample.response
        "You should draw #{thing}"
      end
    end
  end
end

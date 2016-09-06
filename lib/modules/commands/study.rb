module DrawBot
  module DiscordCommands
    # Gives you random thing to study!
    module Study
      extend Discordrb::Commands::CommandContainer
      command(:study,
              description: 'Gives you random thing to study!',
              usage: "#{BOT.prefix}study") do |_event|
        response = Database::Response.where(key: 'study').all.sample.response
        "The body part you get to study is #{response}"
      end
    end
  end
end

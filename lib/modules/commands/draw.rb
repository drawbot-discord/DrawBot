module DrawBot
  module DiscordCommands
    # Gives you a random idea of what to draw!
    module Draw
      extend Discordrb::Commands::CommandContainer
      command(:draw,
              description: 'Gives you a random idea of what to draw!',
              usage: "#{BOT.prefix}draw") do |event|
        single_or_combo = %w(single single single combo).sample
        if single_or_combo == 'single'
          thing = Database::Response.where(key: 'draw').all.sample.response
          event << "You should draw #{thing}"
        else
          prefix = Database::Response.where(key: 'combo_prefix').all
                                     .sample
                                     .response
          suffix = Database::Response.where(key: 'combo_suffix').all
                                     .sample
                                     .response
          event << "You should draw something #{prefix} #{suffix}"
        end
      end
    end
  end
end

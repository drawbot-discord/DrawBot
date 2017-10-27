module Bot
  module DiscordCommands
    # Responds with "Pong!".
    # This used to check if bot is alive
    module Ping
      extend Discordrb::Commands::CommandContainer
      command(:echo) do |event|
        break unless event.user.id == CONFIG.owner
        "Olly olly oxen free! `#{Time.now - event.timestamp} ms`"
      end
    end
  end
end

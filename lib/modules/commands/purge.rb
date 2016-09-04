module DrawBot
  module DiscordCommands
    # Prunes (deletes) a channel's messages en-masse.
    module Prune
      extend Discordrb::Commands::CommandContainer
      command(:prune,
              description: 'Prunes (deletes) a channel\'s messages en-masse.',
              usage: "#{BOT.prefix}prune 2-100",
              min_args: 1,
              max_args: 1,
              help_available: false) do |event, number|
        break unless event.user.id == CONFIG.owner
        number = number.nil? ? 100 : number.to_i
        event.channel.prune(number) if number.between?(2, 100)
      end
    end
  end
end

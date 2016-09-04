module DrawBot
  module DiscordCommands
    # Returns the bot's invite url.
    module Invite
      extend Discordrb::Commands::CommandContainer
      command(:invite,
              description: 'Prints the bot\'s invite url.',
              usage: "#{BOT.prefix}invite",
              help_available: false) do |event|
        break unless event.user.id == CONFIG.owner
        event.bot.invite_url
      end
    end
  end
end

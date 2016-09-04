module Bot
  module DiscordEvents
    # This event is processed when the bot connects to Discord.
    module Ready
      extend Discordrb::EventContainer
      ready do |event|
        event.bot.user(CONFIG.owner).pm 'Bot online'
        event.bot.game = 'Discordrb'
      end
    end
  end
end

module DrawBot
  module DiscordEvents
    # This event is processed when the bot connects to Discord.
    module Ready
      extend Discordrb::EventContainer
      ready do |event|
        event.bot.channel(CONFIG.devchannel).send_message '🎨'
        event.bot.game = 'with Lune'
      end
    end
  end
end

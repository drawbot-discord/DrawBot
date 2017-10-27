module Bot
  module DiscordEvents
    # This event is processed each time the bot succesfully connects to discord.
    module Ready
      extend Discordrb::EventContainer
      message(with_text: '/o/') do |event|
        event.respond '\o\ '
      end

      message(contains:/(sparkl)|(sparkling)|(sparkled)/i) do |event|
        event.respond '༼∩ •́ ヮ •̀ ༽⊃━☆ﾟ. * ･ ｡ﾟ'
      end
    end
  end
end

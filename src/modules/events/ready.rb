module Bot
  module DiscordEvents
    # This event is processed each time the bot succesfully connects to discord.
    module Ready
      extend Discordrb::EventContainer
      $userinfo = YAML.load(File.read('data/userinfo.yaml'))
      ready do |event|
        event.bot.game = CONFIG.game
        avatar = File.open('media/avatar.jpg','rb')
        event.bot.profile.avatar = avatar
        scheduler = Rufus::Scheduler.new
        scheduler.cron '0 0 * * *' do
          #update all users
          $userinfo["users"].each do |id, data|
            data["stipend"] = $userinfo['stipend']
          end
          bot.channel(DEVCHANNEL).send_message("Stipends reset to: `#{$userinfo['stipend']}`")
          nil
        end
      end
    end
  end
end

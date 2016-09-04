module DrawBot
  module DiscordEvents
    # This event is processed when the bot connects to Discord.
    module Ready
      extend Discordrb::EventContainer
      ready do |event|
        event.bot.channel(CONFIG.devchannel).send_message '🎨'
        event.bot.game = 'with Lune'

        # Sync Server cache while we were asleep
        event.bot.servers.each do |id, data|
          server_sql = Database::Server.find(discord_id: id)
          next unless server_sql.nil?
          Database::Server.create(discord_id: id,
                                  owner_id: data.owner.id,
                                  discord_name: data.name)
        end
      end
    end
  end
end

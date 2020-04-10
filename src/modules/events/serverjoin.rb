module Bot
  module DiscordEvents
    # This event is processed each time the bot succesfully connects to discord.
    module ServerJoin
      extend Discordrb::EventContainer
      DEV_CHANNEL = 697260397245235250
      
      server_create do |event|
        message =
          <<~MESSAGE
        **New Server Joined (Shard #{event.bot.shard_key[0]}/#{event.bot.shard_key[1]})**
        Name: #{event.server.name}
        Owner: #{event.server.owner.distinct} (#{event.server.owner.id})
        Members: #{event.server.member_count}
        -------------------------
        Total Servers: #{event.bot.servers.count}
        Total Cached Users: #{event.bot.users.count}
          MESSAGE
        event.bot.channel(DEV_CHANNEL).send_message(message)

        # event.bot.channel(DEV_CHANNEL).send_embed do |e|
        #   e.thumbnail = { url: event.server.icon_url }
        #   e.add_field name: 'New Server Joined', value: event.server.name, inline: true
        #   e.add_field name: "Connected servers/users", value: "Servers: #{event.bot.servers.count}\n"\
        #                     "Cached Users: #{event.bot.users.count}", inline: true
        #   e.add_field name: 'Server Owner', value: "#{event.server.owner.distinct}\n#{event.server.owner.id}", inline: true
        #   # Removing online members due to running stateless.
        #   e.add_field name: 'Total Members', value: event.server.member_count, inline: true
        # end
      end

      server_delete do |event|
        message =
          <<~MESSAGE
        **Server Left (Shard #{event.bot.shard_key[0]}/#{event.bot.shard_key[1]})**
        Name: #{event.server.name}
        ----------------------
        Total Servers: #{event.bot.servers.count}
        Total Cached Users: #{event.bot.users.count}
          MESSAGE
        event.bot.channel(DEV_CHANNEL).send_message(message)
      #  event.bot.channel(DEV_CHANNEL).send_embed do |e|
      #    e.thumbnail = { url: event.server.icon_url }
      #    e.add_field name: 'Server Left', value: event.server.name, inline: true
      #    e.add_field name: 'Connected servers/users', value: "Servers: #{event.bot.servers.count}\nCached Users: #{event.bot.users.count}", inline: true
      #  end
      end

      # Post bot stats to dbots.
      server_create do |event|
        shard_id, shard_total = event.bot.shard_key
        
        RestClient.post("https://discordbots.org/api/bots/186636165938413569/stats",
                        {"server_count": event.bot.servers.count,
                         "shard_count": shard_total,
                         "shard_id": shard_id
                        }, :'Authorization' => CONFIG.dbotstoken, :'Content-Type' => :json)
      end
    end
  end
end

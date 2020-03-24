module Bot
  module DiscordEvents
    # This event is processed each time the bot succesfully connects to discord.
    module ServerJoin
      extend Discordrb::EventContainer
      DEV_CHANNEL = 378478860095848448
      #DEV_CHANNEL = 584901156795318276
      server_create do |event|
        message =
          <<~MESSAGE
        **New Server Joined**
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
        **Server Left**
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
        RestClient.post("https://discordbots.org/api/bots/186636165938413569/stats", {"server_count": event.bot.servers.count}, :'Authorization' => CONFIG.dbotstoken, :'Content-Type' => :json);
      end
    end
  end
end

module Bot
  module DiscordEvents
    # This event is processed each time the bot succesfully connects to discord.
    module ServerJoin
      extend Discordrb::EventContainer
      server_create do |event|
        event.bot.channel(378478860095848448).send_embed do |e|
          e.thumbnail = { url: event.server.icon_url }
          e.add_field name: 'New Server Joined', value: event.server.name, inline: true
          e.add_field name: "Connected servers/users",
                     value:  "Servers: #{event.bot.servers.count}\n"\
                             "Users: #{event.bot.users.count}", inline: true
          e.add_field name: 'Online Members',
            value: "#{event.server.online_members.count}", inline: true
          e.add_field name: 'Total Members',
            value: "#{event.server.member_count}", inline: true
        end
      end
    end
  end
end

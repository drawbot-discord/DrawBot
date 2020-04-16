module Bot
  module DiscordCommands
    # Document your command
    # in some YARD comments here!
    module Information
      extend Discordrb::Commands::CommandContainer


      command(:commands) do |event|
        event << "<https://github.com/LeggoMyEcho/DrawBot/wiki/Commands>"
      end

      command(:info,
              description: 'Get some general info about drawbot!') do |event|
              event.channel.send_embed do |e|
              e.description = '**DrawBot General information**'
              e.thumbnail = { url: event.bot.profile.avatar_url }
              e.add_field name: 'I am worked on by',
                         value: "`Echo#3389`\n"\
                                "`z64#1337`\n"\
                                "`PixeL#1337`\n"\
                                "`Cyan「Alter」#3717`", inline: true
               e.add_field name: "Connected servers/users",
                          value:  "Servers: #{event.bot.servers.size}\n"\
                                  "Users: #{event.bot.users.size}", inline: true
               e.add_field name: 'Invite link',
                          value: "[Click here](https://discordapp.com/oauth2/authorize?client_id=186636037001445377&scope=bot&permissions=201351236)", inline: false
                   e.add_field name: 'My server',
                          value: "[Click here](https://discord.gg/rYJrhSH)", inline: true
               e.add_field name: 'Github',
                          value: "[Click here](https://github.com/LeggoMyEcho/DrawBot)", inline:true
               e.add_field name: "\u200b",
                          value: "DrawBot `2.0 Beta` Ruby: `#{RUBY_VERSION}` Discordrb: `#{Discordrb::VERSION}`"
              e.footer = { text: "This operation took #{Time.now - event.timestamp} seconds to calculate" }
              end
      end


              command(:serverstat,
                          description: "Get general information about your server!",
                          usage: "`~serverstat`") do |event|
                next "I don't have permission to do that!" unless event.bot.profile.on(event.server).permission? :manage_server
                  event.channel.send_embed do |e|
                  e.thumbnail = { url: event.server.icon_url }
                  e.description = 'General Server-wide information'
                  e.add_field name: 'Server Owner',
                    value: event.server.owner.name, inline: true
                  e.add_field name: 'Server Name',
                    value: event.server.name, inline: true
                  e.add_field name: 'Server Creation Date',
                    value: event.server.creation_time.strftime("%B %e, %Y"), inline:true
                  e.add_field name: 'Voice Region',
                    value: event.server.region.upcase, inline: true
                  e.add_field name: 'Online Members',
                    value: "#{event.server.online_members.size}", inline: true
                  e.add_field name: 'Total Members',
                    value: "#{event.server.member_count}", inline: true
                  e.add_field name: 'Amount of Roles',
                    value: event.server.roles.size, inline: true
                  e.add_field name: 'Amount of Channels',
                    value: event.server.channels.size, inline: true
                  e.add_field name: 'Banned Members',
                    value: event.server.bans.size, inline: true
                  e.add_field name: 'Verification Level',
                    value: event.server.verification_level.upcase, inline: true
                  e.add_field name: 'Custom emojis on server?',
                    value: event.server.any_emoji?, inline: true
                end
              end

#litterally stolen from Cyan
      command(:userstat,
              description: "Get general info about yourself!",
              usage: "`~userstat`") do |event|
              event.channel.send_embed do |e|
              e.description = 'User information'
                #Grabs the URL for the user's avater
              e.thumbnail = { url: event.user.avatar_url }
                #Returns the username of the user that initiated the command
              e.add_field name: 'Username',
                value: event.user.name, inline: true
                #Grabs the discriminator number for the user
              e.add_field name: 'Discriminator',
                value: "##{event.user.discriminator}", inline: true
                #Grabs user's nickname on server
              e.add_field name: 'People know you as:',
                value: event.user.display_name, inline: true
                #Grabs the user's userID
              e.add_field name: 'UserID',
                value: event.user.id, inline: true
                #Grabs the time the suer joined the server the command is run on
              e.add_field name: 'You joined this server on  ',
                value: event.user.joined_at.strftime("%B %e, %Y at %r"), inline: true
                #Grabs the time the user created his/her/their account
              e.add_field name: 'You created your account on',
                value: event.user.creation_time.strftime("%B %e, %Y at %r"), inline: true
            end
      end
    end
  end
end

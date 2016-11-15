#Public/Utility commands
module DrawBot
  module DiscordCommands
    module UtilityCommands
      extend Discordrb::Commands::CommandContainer
      command(:commands,
              description: 'Lists the publicly available commands',
              usage: "#{BOT.prefix}commands") do |event|
        'https://github.com/LeggoMyEcho/DrawBot/wiki/Commands'
      end

      #------------Eval-----------#
     command(:eval,
                 help_available: false) do |event, *code|
                  break unless event.user.id == 132893552102342656
                  begin
                  eval code.join(' ')
                  rescue => e
                  "An error occured, and I heard something\
                        break :disappointed: ```#{e}```"
                  end
                end

     command (:getdb,
                   help_available: false) do |event|
                    break unless event.channel.id == DEVCHANNEL
                    file = File.open('db.yaml')
                    event.channel.send_file(file)
                   end
    end
  end
end

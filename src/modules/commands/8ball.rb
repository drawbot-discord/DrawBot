module Bot
  module DiscordCommands
    # Document your command
    # in some YARD comments here!
    module Eightball
      extend Discordrb::Commands::CommandContainer
      $db = YAML.load(File.read('data/8ball.yaml'))
      EIGHTBALL = $db['eightball']
      EIGHTBALLZ = $db['eightballz']

      command(:'8ball') do |event, *message|
        message = message.join(' ')
        fortune = EIGHTBALL.select { |e| !e['fortune'].empty? }.sample['fortune']
        event << "#{event.user.mention} `#{message}`: #{fortune}"
      end

      command(:eris) do |event, *message|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["eris", "unlocksfw"]
        next event.respond "I need the `eris` or `unlocksfw` role for that, silly" if check.empty?
         message = message.join(' ')
          index = rand 0..EIGHTBALL.length-1
          fortune = EIGHTBALL[index]['fortune']
          eris = EIGHTBALL[index]['eris']
            event.channel.send_embed do |e|
            e.thumbnail = { url: eris }
            e.author = { name: event.user.name, icon_url: event.user.avatar_url }
            e.description = "`#{message}`"
            e.add_field name: "\u200b", value: fortune, inline: true
        end
      end

      command(:zii) do |event, *message|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["zii", "unlocksfw"]
        next event.respond "I need the `zii` or `unlocksfw` role for that, silly" if check.empty?
         message = message.join(' ')
          index = rand 0..EIGHTBALLZ.length-1
          zfortune = EIGHTBALLZ[index]['zfortune']
          zii = EIGHTBALLZ[index]['zii']
            event.channel.send_embed do |e|
            e.thumbnail = { url: zii }
            e.author = { name: event.user.name, icon_url: event.user.avatar_url }
            e.description = "`#{message}`"
            e.add_field name: "\u200b", value: zfortune, inline: true
        end
      end
    end
  end
end

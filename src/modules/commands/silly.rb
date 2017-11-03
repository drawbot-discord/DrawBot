module Bot
  module DiscordCommands
    # Document your command
    # in some YARD comments here!
    module SillyCommands
      extend Discordrb::Commands::CommandContainer
      $silly = YAML.load(File.read('data/silly.yaml'))
      $selfie = YAML.load(File.read('data/selfie.yaml'))

      command(:told) do |event|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["spam", "unlocksfw"]
        next event.respond "I need the `playful` or `spam` role for that, silly" if check.empty?
        ":negative_squared_cross_mark: Not Told\n"\
        "#{$silly['told'].sample(5).join("\n")}"
      end

      command(:rekt) do |event|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["spam", "unlocksfw"]
        next event.respond "I need the `spam` or `unlocksfw` role for that, silly" if check.empty?
        ":negative_squared_cross_mark: Not REKT\n"\
        ":white_check_mark: REKT\n"\
        ":white_check_mark: Really Rekt\n"\
        "#{$silly['rekt'].sample(4).join("\n")}"
      end


      command(:joke,
              description: "Tells an offensive joke.",
              usage: '~joke') do |event|
        next event.respond "I'm sorry. I can't do that because this is a SFW channel." unless event.channel.nsfw?
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["offensive", "unlocknsfw"]
        next event.respond "I need the `offensive` or `unlocknsfw` role for that, silly" if check.empty?
        "#{$silly['dirtyjoke'].sample}"
      end

      command(:pun) do |event|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
        next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
        "#{$silly['Puns'].sample}"
      end

      command(:'lewd') do |event|
        "#{$silly['lewd'].sample}"
      end


      command(:pout) do |event|
        "#{$silly['pout'].sample}"
      end

      command(:nick,
              description: "Give yourself a random name, or choose one",
              usage: '~nick (optional name) and clear your name with ~nick clear') do |event, *nick|
        nick = nick.join ' '
        names = ($character['malenames'] + $character['femalesnames'] + $character['fantasynames'] + $dt['DrawTopic'])
        nick = names.sample if nick.empty?
        nick = nil if nick == 'clear'
        oldname = event.user.display_name
        begin
          event.user.nickname = nick
          if nick.nil?
            'Nickname cleared!'
          else
            "#{oldname} has changed their name to **#{nick.upcase}**"
          end
        rescue => e
         "Sorry sweetheart, something went wrong.\n"\
         "```#{e}```"
        end
      end

      command(:doit) do |event|
        event.channel.send_embed do |e|
          e.image = { url: "http://i.imgur.com/grXCyq2.png" }
        end
      end

      command(:selfie,
              description: "See my selfies of me, DrawBot AKA Eris!",
              usage: '~selfie') do |event|
              check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["unlocknsfw"]
              next event.respond "I need the `unlocknsfw` role for that, silly" if check.empty?
        event.channel.send_embed do |e|
          e.image = { url: "#{$selfie['Selfie'].sample}" }
          e.add_field name: "\u200b", value: "[Here's an album of all my fanart :wink:](http://imgur.com/a/8lWRt)", inline: true
        end
      end
    end
  end
end

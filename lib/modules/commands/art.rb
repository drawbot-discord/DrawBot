module Bot
  module DiscordCommands
    # Document your command
    # in some YARD comments here!
    module ArtCommands
      extend Discordrb::Commands::CommandContainer
      #$dct = YAML.load(File.read('data/dct.yaml'))
      #$dt = YAML.load(File.read('data/dt.yaml'))
      #$ldt = YAML.load(File.read('data/ldt.yaml'))
      #$ndt = YAML.load(File.read('data/ndt.yaml'))
      #$sdt = YAML.load(File.read('data/sdt.yaml'))
      #$outfit = YAML.load(File.read('data/outfit.yaml'))
      #$refdb = YAML.load(File.read('data/refdb.yaml'))
      #$colour = YAML.load(File.read('data/colour.yaml'))
      #$fpose = YAML.load(File.read('data/fpose.yaml'))
      #$scene = YAML.load(File.read('data/scene.yaml'))
      #DrawTopic = $dt['DrawTopic']
      #DrawComboTopic = $dct['DrawComboTopic']
      #LewdDrawTopic = $ldt['LewdDrawTopic']
      #NormalDrawTopic = $ndt['NormalDrawTopic']
      #Study = $sdt['StudyDrawTopic']
      #Outfit = $outfit['Outfit']
      #Refs = $refdb['Outfit']
      command(:draw,
              description: 'Generate a random thing to draw!',
              usage: "~draw") do |event, *message|
              message = message.join(' ')
              if message.empty?
              rndm = rand(1..3)
               if rndm == 1
                 "You should draw #{DrawTopic.sample}"
               elsif rndm.between?(2,3)
                 "You should draw #{DrawComboTopic.sample} #{NormalDrawTopic.sample}"
               end
               else
                  "You should draw #{message} #{NormalDrawTopic.sample}"
              end
      end

      command(:drawlewd,
              description: "Generate a random lewd thing to draw!",
              usage: '~drawlewd') do |event, *message|
              next event.respond "I'm sorry. I can't do that because this is a SFW channel." unless event.channel.nsfw?
              check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["lewd", "unlocknsfw"]
              next event.respond "I need the `lewd` or `unlocknsfw` role for that, silly" if check.empty?
              message = message.join(' ')
              if message.empty?
                rndm = rand(1..3)
              if rndm == 1
                "You should draw #{event.user.display_name} #{LewdDrawTopic.sample}"
              elsif rndm.between?(2,3)
                "You should draw #{DrawComboTopic.sample} #{LewdDrawTopic.sample}"
              end
              else
                "You should draw #{message} #{LewdDrawTopic.sample}"
              end
      end

      command(:outfit,
              description: "Generate a random outfit for you, or your character!",
              usage: '~outfit') do |event|
              event << "#{event.user.mention} your outfit is #{Outfit.sample}"
              event << "I bet you'll look great in it~"
      end

      command(:study,
              description: "Generate a random bodypart to practice drawing!",
              usage: '~study') do |event|
              event << "The body part you get to study is #{Study.sample}"
              event << "You can do it!"
      end

      command(:fpose,
              description: "Generate a random female image from the Playboy Centerfolds (1958-2008) as a drawing reference (NSFW)",
              usage: '~fpose') do |event|
              next event.respond "I'm sorry. I can't do that because this is a SFW channel." unless event.channel.nsfw?
              check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["fpose", "unlocknsfw"]
              next event.respond "I need the `fpose` or `unlocknsfw` role for that, silly" if check.empty?
              event << "The pose you get is #{$fpose['fpose'].sample}"
      end

      command(:scene,
              description: "Get a random scene to draw/paint!",
              usage: '~scene') do |event|
        event << "You should draw #{$scene['subject'].sample} #{$scene['weather'].sample} #{$scene['timeofday'].sample} in #{$scene['seasons'].sample}"
      end

      command(:colour,
              description: "Generate a random set of complementary colours!",
              usage: '~colour') do |event, input|
                options = [
                  "Complementary",
                  "Split",
                  "Triadic",
                  "Tetriadic",
                  "Analagous"
                  ]
                output =
                  case input
                    when "complementary"
                      comp_color(h,s,l)
                    when "comp"
                      comp_color(h,s,l)
                    when "split"
                      split_comp(h,s,l)
                    when "triadic"
                      triadic(h,s,l)
                    when "tri"
                      triadic(h,s,l)
                    when "tetriadic"
                      tetradic(h,s,l)
                    when "analagous"
                      analagous(h,s,l)
                    else
                      randcolor
                  end
                  event.channel.send_embed do |e|
                    e.add_field name: 'TITLE', value: "CONTENT", inline: true
                    e.add_field name: "\u200b", value: output, inline: true
                    e.add_field name: "\u200b", value: options, inline: true
                  end
      end

      #COLOUR SHADES COMMAND
      command(:colourshade,
              description: "Generate shades of a random character",
              usage: '~colourshade') do |event|
        event << "Your colour shades are"
        event << "#{Colourshade.sample}"
        event << "Oooh they're so pretty~"
      end

      command(:references,
              description: 'Lists artistic reference galleries',
              usage: '~references (topic)') do |event, *args|
        args = args.join(' ')
        unless args.empty?
          #finds the ref listed with the arg you use
          ref = $refdb['refs'].find { |r| r['title'].casecmp(args).zero? }
          unless ref.nil?
            event.channel.send_embed do |e|
            e.add_field name: "#{ref['title']}", value:"#{ref['url']}", inline: true
            e.footer = { text: $refdb['refs'].collect { |r| "#{r['title']}" }.join(', ') }
            end
            return
          end
        end
        #this is for when you don't have arguments, to find the list of refs
        event.channel.send_embed do |e|
            e.add_field name: 'I couldn\'t find that reference..',\
            value: "\u200b" ,inline: true
            e.add_field name: 'Here is a list of available references:',\
            value: $refdb['refs'].collect { |r| "`#{r['title']}`" }.join(', '), inline: true
        end
      end

      command(:submit,
              description: "Submit to the gallery!",
              usage: "`~submit #channel (link)`") do |event, channel, url, *message|
       next event.respond('I need a channel to post to, sweetheart!') unless /\d{18}/.match(channel)
       next event.respond('I need a link, hun!') unless /(http|https):\/\/(.)*/i.match(url)
       num = Time.now.strftime("%j%H%M%S")
       #event.bot.channel(channel[2..-1]).send_message("**Submission number** `#{num}`"\
       #"\n#{event.user.mention} posted their art #{url}"\
       #"\n#{message.join(" ")}")
       event.bot.channel(channel[2..-1]).send_embed do |e|
           e.author = { name: event.user.name, icon_url: event.user.avatar_url }
           e.image  = { url: url }
           e.description = "#{message.join(" ")}"
           e.footer = { text:"Post Number #{num}" }
       end
      end
    end
  end
end

module Bot
  module DiscordCommands
    # Document your command
    # in some YARD comments here!
    module ArtCommands
      extend Discordrb::Commands::CommandContainer
      $dct = YAML.load(File.read('data/dct.yaml'))
      $dt = YAML.load(File.read('data/dt.yaml'))
      $ldt = YAML.load(File.read('data/ldt.yaml'))
      $ndt = YAML.load(File.read('data/ndt.yaml'))
      $sdt = YAML.load(File.read('data/sdt.yaml'))
      $outfit = YAML.load(File.read('data/outfit.yaml'))
      $refdb = YAML.load(File.read('data/refdb.yaml'))
      $colour = YAML.load(File.read('data/colour.yaml'))
      $fpose = YAML.load(File.read('data/fpose.yaml'))
      $scene = YAML.load(File.read('data/scene.yaml'))
      DrawTopic = $dt['DrawTopic']
      DrawComboTopic = $dct['DrawComboTopic']
      LewdDrawTopic = $ldt['LewdDrawTopic']
      NormalDrawTopic = $ndt['NormalDrawTopic']
      Study = $sdt['StudyDrawTopic']
      Outfit = $outfit['Outfit']
      Refs = $refdb['Outfit']
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
              usage: '~colour OPTION') do |event, input|
                module_function
              def toRGB(hue, sat, lum)
                temp_1 =
                case
                 when lum < 0.0
                   lum x (1.0 * sat)
                 when lum > 0.0
                   (lum + sat) - lum
                end
                temp_2 = (2 * lum) - temp_1.to_f
                h = (hue/360.0)
                temp_r = (h + 0.333)
                temp_r = temp_r + 1 if temp_r < 0
                temp_r = temp_r - 1 if temp_r > 1
                temp_g = h
                temp_b = (h - 0.333)
                temp_b = temp_b + 1 if temp_b < 0
                temp_b = temp_b - 1 if temp_b > 1
              red =
                case
                  when 6 * temp_r < 1
                    temp_2 + (temp_1 - temp_2) * 6 * temp_r
                  when 2 * temp_r < 1
                    temp_1
                  when 3 * temp_r < 2
                    temp_2 + (temp_1 - temp_2) * (0.666 - temp_r * 6)
                  else
                    temp_2
                end
              green =
                  case
                    when 6 * temp_g < 1
                      temp_2 + (temp_1 - temp_2) * 6 * temp_g
                    when 2 * temp_g < 1
                      temp_1
                    when 3 * temp_g < 2
                      temp_2 + (temp_1 - temp_2) * (0.666 - temp_g * 6)
                    else
                      temp_2
                  end
              blue =
                  case
                    when 6 * temp_b < 1
                      temp_2 + (temp_1 - temp_2) * 6 * temp_b
                    when 2 * temp_b < 1
                      temp_1
                    when 3 * temp_b < 2
                      temp_2 + (temp_1 - temp_2) * (0.666 - temp_b * 6)
                    else
                      temp_2
                  end
                "#{red.floor.to_s(16)}#{green.floor.to_s(16)}#{blue.floor.to_s(16)}"
              end

              $r , $g , $b =  Array.new(3) { rand(0xff) }
              def self.div(a)
                (a / 255.00)
              end

              min, max = [div($r), div($g), div($b)].minmax
              min = min
              max = max

              def lum(mx,mn)
                num = ((mx + mn)/2)
                (num*100)
              end

              def sat(l, mx, mn)
                if l < 0.50
                  s = (mx-mn)/(mx+mn)
                elsif l > 0.5
                  s = (mx-mn)/(2.0-(mx+mn))
                elsif mx = mn
                  0
                end
              end

              def hue(mx, mn, hR, hG, hB)
                h =
                case mx
                  when mn
                    0
                  when hR
                    (hG-hB)/(mx-mn)
                  when hG
                    2.0 + (hB-hR)/(mx-mn)
                  when hB
                    4.0 + (hR-hG)/(mx-mn)
                end
                h = (h * 60)
                h += 360 if h < -1
                h
              end

              $h = hue(max, min, div($r), div($g), div($b))
              $s = sat(lum(max,min), max, min)
              $l = lum(max,min)


              def comp_color(h,s,l)
                comp_h = (h + 180) % 360
                "https://www.colorcombos.com/combomaker_image.php?design=squares-outlined.png&output_width=350&colors=#{toRGB(h, s, l)},#{toRGB(comp_h, s, l)}&background_color=6F6F6F.png"
              end
              $comp_color = comp_color($h,$s,$l)

              def split_comp(h,s,l)
                first = (h + 150) % 360
                second = (h + 210) % 360
                "https://www.colorcombos.com/combomaker_image.php?design=squares-outlined.png&output_width=500&colors=#{toRGB(h, s, l)},#{toRGB(first, s, l)},#{toRGB(second, s, l)}&background_color=6F6F6F.png"
              end
              $split_comp = split_comp($h,$s,$l)

              def triadic(h,s,l)
                first = (h + 120) % 360
                second = (h + 240) % 360
                "https://www.colorcombos.com/combomaker_image.php?design=squares-outlined.png&output_width=500&colors=#{toRGB(h, s, l)},#{toRGB(first, s, l)},#{toRGB(second, s, l)}&background_color=6F6F6F.png"
              end
              $triadic = triadic($h,$s,$l)

              def tetradic(h,s,l)
                first = (h + 90) % 360
                second = (h + 180) % 360
                third = (h + 270) % 360
                "https://www.colorcombos.com/combomaker_image.php?design=squares-outlined.png&output_width=500&colors=#{toRGB(h, s, l)},#{toRGB(first, s, l)},#{toRGB(second, s, l)},#{toRGB(third, s, l)}&background_color=6F6F6F.png"
              end
              $tetradic = tetradic($h,$s,$l)

              def analagous(h,s,l)
                first = (h + 30) % 360
                second = (h + 60) % 360
                third = (h + 90) % 360
                "https://www.colorcombos.com/combomaker_image.php?design=squares-outlined.png&output_width=500&colors=#{toRGB(h, s, l)},#{toRGB(first, s, l)},#{toRGB(second, s, l)},#{toRGB(third, s, l)}&background_color=6F6F6F.png"
              end
              $analagous = analagous($h,$s,$l)

              def randcolor
                a, b, c, d, e, f,
                g, h, i,j ,k ,l,
                m, n, o, p, q, r = Array.new(18) { rand(0xff).to_s(16) }
                "https://www.colorcombos.com/combomaker_image.php?design=squares-outlined.png&output_width=500&colors=#{a+b+c},#{d+e+f},#{g+h+i},#{j+k+l},#{m+n+o},#{p+q+r}&background_color=6F6F6F.png"
              end

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
                      comp_color($h,$s,$l)
                    when "comp"
                      comp_color($h,$s,$l)
                    when "split"
                      split_comp($h,$s,$l)
                    when "triadic"
                      triadic($h,$s,$l)
                    when "tri"
                      triadic($h,$s,$l)
                    when "tetriadic"
                      tetradic($h,$s,$l)
                    when "analagous"
                      $analagous
                    else
                      randcolor
                  end

                  event.channel.send_embed do |e|
                    e.image       = { url: output }
                    e.footer      = { text: "OPTIONS: #{options.join(", ")}" }
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

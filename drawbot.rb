require 'discordrb'
require 'yaml'
require 'rest_client'
require 'rufus-scheduler'
require 'nokogiri'
require 'rest-client'
require 'json'
require 'usagewatch'
require 'set'


puts ' '
puts ' '
puts ' '
puts 'I think it\'s time to blow this thing.'
puts 'Get everybody and their stuff together'
puts 'Okay, three, two, one let\'s jam.'
puts '.. '
puts '... '
puts '.... '
puts '..... '
puts ' '
puts ' '
puts ' '

#-------YAML THINGS------#

$db = YAML.load(File.read('db.yaml'))
$serverlist = YAML.load(File.read('serverlist.yaml'))
$pc = YAML.load(File.read('pc.yaml'))
$wl = YAML.load(File.read('wl.yaml'))
$graff = YAML.load(File.read('graff.yaml'))
$prompt = YAML.load(File.read('prompt.yaml'))


BoopAction = $db['BoopAction']
WaterContainer = $db['WaterContainer']
Outfit = $db['Outfit']
DrawTopic = $db['DrawTopic']
DrawComboTopic = $db['DrawComboTopic']
LewdDrawTopic = $db['LewdDrawTopic']
NormalDrawTopic = $db['NormalDrawTopic']
Artists = $db['Artists']
LewdDrawFagTopic = $db['LewdDrawFagTopic']
Snake = $db['Snake']
Puns = $db['Puns']
Pokemon = $db['Pokemon']
Token = $db['token']
Fpose = $db['fpose']
Pout = $db['pout']
Told = $db['told'].join("\n")
Rekt = $db['rekt'].join("\n")
Lewd = $db['lewd']
Compcolour = $db['compcolour']
EIGHTBALL = $db['eightball']
EIGHTBALLZ = $db['eightballz']
Study = $db['StudyDrawTopic']
Colourshade = $db['shadecolour']
References = $db['refs']
Malenames = $db['malenames']
Femalenames = $db['femalesnames']
FantasyNames = $db['fantasynames']
DirtyJoke = $db['dirtyjoke']
Weather = $db['weather']
Seasons = $db['seasons']
TimeofDay = $db['timeofday']
Subject = $db['subject']
Selfie = $db['Selfie']
hairLength = $pc['hairlength']
height = $pc['height']
hair = $pc['hair']
bodytype = $pc['bodytype']
race = $pc['race']
pclass = $pc['class']
stats = $pc['stats']
lgd = $pc['lgdeity']
lnd = $pc['lndeity']
led = $pc['ledeity']
nd = $pc['ndeity']
ngd = $pc['ngdeity']
ned = $pc['nedeity']
cgd = $pc['cgdeity']
cnd = $pc['cndeity']
ced = $pc['cedeity']
wordlist = $wl['list']
graff = $graff['LIST']
prompt = $prompt['prompt']




DEVCHANNEL = 222032313154928640
DRAWCHANNEL = 175579371975868416

class Array
   def included_in? array
     array.to_set.superset?(self.to_set)
   end
end


bot = Discordrb::Commands::CommandBot.new token: $db['token'], client_id: 186636165938413569, prefix: '~'

#restart bot
bot.command(:restart,
            description: "restarts the bot") do |event|
        break unless event.user.id == 132893552102342656
      event.channel.send_message("Sure thing hun!")
      event.channel.send_message("Restart issued.. :wrench:")
      system('git pull')
    bot.stop
  exit
end


bot.ready do |event|
  event.bot.send_message(DEVCHANNEL, "Drawbot online! Let's get some art done!")
  avatar = File.open('media/avatar.jpg','rb')
  event.bot.profile.avatar = avatar
  event.bot.game = "~commands"
  #event.bot.name = "DrawBat"
  event.bot.send_message(DEVCHANNEL, "I'm in `#{event.bot.servers.count}` servers and they are;
 - #{event.bot.servers.collect { |_, s| s.name }.sort_by(&:downcase).join("\n - ")}")
 #event.bot.send_message(DEVCHANNEL, event.bot.servers.collect { |_, s| s.name }.join(', '))
  scheduler = Rufus::Scheduler.new
  scheduler.cron '0 0 * * *' do
    #update all users
    $db["users"].each do |id, data|
      data["stipend"] = $db['stipend']
    end
    bot.channel(DEVCHANNEL).send_message("Stipends reset to: `#{$db['stipend']}`")
    nil
  end
end

bot.command(:help) do |event|
"Please use `~commands`, thanks hun!"
end

bot.command(:commands) do |event|
  event << "<https://github.com/LeggoMyEcho/DrawBot/wiki/Commands>"
end



bot.command(:info,
             description: 'Get some general info about drawbot!') do |event|
               usw = Usagewatch
               event.channel.send_embed do |e|
   e.description = '**DrawBot General information**'
   e.thumbnail = { url: event.bot.profile.avatar_url }
   e.add_field name: 'I am worked on by',
              value: "`Echo#5248`\n"\
                      "`z64#2639`\n"\
                      "`Cyan「Alter」#3717`", inline: true
    e.add_field name: "Connected servers/users",
               value:  "Servers: #{event.bot.servers.count}\n"\
                       "Users: #{event.bot.users.count}", inline: true
    e.add_field name: 'Outbound bandwidth',
               value: "#{usw.uw_bandtx} Mbit/s", inline: true
    e.add_field name: 'Inbound bandwidth',
               value: "#{usw.uw_bandrx} Mbit/s", inline: true
    e.add_field name: 'Avg CPU load',
               value: "#{usw.uw_load}", inline: true
    e.add_field name: 'TCP/UDP connections',
               value: "#{usw.uw_tcpused}/#{usw.uw_udpused}", inline: true
    e.add_field name: 'Disk taken',
               value: "#{usw.uw_diskused}GB (#{usw.uw_diskused_perc}%)", inline: true
    e.add_field name: 'Invite link',
               value: "[Click here](https://discordapp.com/oauth2/authorize?client_id=186636037001445377&scope=bot&permissions=268435493)", inline: true
    e.add_field name: 'CPU',
               value: "#{usw.uw_cpuused}%", inline: true
        e.add_field name: 'My server',
               value: "[Click here](discord.gg/u3a2Ck9)", inline: true
    e.add_field name: 'RAM usage',
               value: "#{usw.uw_memused}", inline: true
    e.add_field name: 'Github',
               value: "[Click here](github.com/LeggoMyEcho/DrawBot)", inline:true
    e.add_field name: "\u200b",
               value: "DrawBot `.9 Alpha` Ruby: `#{RUBY_VERSION}` Discordrb: `#{Discordrb::VERSION}`"
    e.footer = { text: "This operation took #{Time.now - event.timestamp} seconds to calculate" }
  end
end





#------------ART COMMANDS-----------#

bot.command(:draw,
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

bot.command(:drawlewd,
             description: "Generate a random lewd thing to draw!",
             usage: '~drawlewd') do |event, *message|
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
                "You should draw #{message} #{NormalDrawTopic.sample}"
             end
end

bot.command(:drawcombo,
             description: "Generate a more random thing to draw!",
             usage: '~drawcombo') do |event|
    event << "You should draw #{DrawComboTopic.sample} #{NormalDrawTopic.sample}\n"\
    "\nThis command will be removed soon; it's been integrated in the `~draw` command"
end

bot.command(:outfit,
             description: "Generate a random outfit for you, or your character!",
             usage: '~outfit') do |event|
  event << "#{event.user.mention} your outfit is #{Outfit.sample}"
  event << "I bet you'll look great in it~"
end

#this is really cool, i'm glad it was added!

bot.bucket :pokemon, limit: 3, time_span: 30, delay: 10
bot.command(:pokemon, bucket: :pokemon, rate_limit_message: 'Too much Pokemon!',
             description: "Gets a random pokemon for you to draw",
             usage: '~pokemon') do |event|
  i = rand(0..720)
  img = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/#{i.next}.png"
  pkmn = JSON.parse(RestClient.get("https://pokeapi.co/api/v2/pokemon/?limit=1&offset=#{i}"))
  event << "Your pokemon to draw is: **#{pkmn['results'][0]['name'].split.map(&:capitalize).join(' ')}**"
  event << img
end

bot.bucket :pokevs, limit: 3, time_span: 30, delay: 10
bot.command(:pokevs, bucket: :pokevs, rate_limit_message: 'Too much Poke-abuse!',
             description: "Gets a random pokemon to fight",
             usage: '~pokevs') do |event|
  i = rand(0..720)
  u = rand(0..720)
  level = rand(1..100)
  level2 = rand(1..100)
  img = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/#{i.next}.png"
  img2 = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/#{u.next}.png"
  pkmn = JSON.parse(RestClient.get("https://pokeapi.co/api/v2/pokemon/?limit=1&offset=#{i}"))
  pkmn2 = JSON.parse(RestClient.get("https://pokeapi.co/api/v2/pokemon/?limit=1&offset=#{u}"))
  event << "A level #{level} **#{pkmn['results'][0]['name'].split.map(&:capitalize).join(' ')}** VS A level #{level2} **#{pkmn2['results'][0]['name'].split.map(&:capitalize).join(' ')}**"
  event << img
  event << img2
end


bot.command(:study,
             description: "Generate a random bodypart to practice drawing!",
             usage: '~study') do |event|
  event << "The body part you get to study is #{Study.sample}"
  event << "You can do it!"
end

bot.command(:fpose,
             description: "Generate a random female image from the Playboy Centerfolds (1958-2008) as a drawing reference (NSFW)",
             usage: '~fpose') do |event|
               check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["fpose", "unlocknsfw"]
               next event.respond "I need the `fpose` or `unlocknsfw` role for that, silly" if check.empty?
  event << "The pose you get is #{Fpose.sample}"
end

bot.command(:poses,
             description: "Get two lists of poses to draw from! (Use ~roll # to choose)",
             usage: '~poses') do |event|
  event << "`~roll 1d98`\nhttps://puu.sh/oNXxK/474217250e.jpg\n`~roll 1d20`\nhttps://puu.sh/oNxer/cb15424c85.jpg"
end

bot.command([:randomchar, :pc],
             description: "Generate a random fantasy character (Pathfinder/DnD)",
             usage: '~randomchar') do |event|
             gender = ["He", "She"].sample
             pronoun = case gender
             when "He"
               then "His"
             when "She"
               then "Her"
             else "their"
             end
             pclasscase = "#{pclass.sample}"
             align = case pclasscase
             when "paladin" then "Lawful Good"
             else $pc['align'].sample
             end
             deity = case align
             when "Lawful Good"
               then "#{lgd.sample}, #{lgd.sample}, #{lgd.sample}"
             when "Lawful Neutral"
               then "#{lnd.sample}, #{lnd.sample}, #{lnd.sample}"
             when "Lawful Evil"
                then "#{led.sample}, #{led.sample}, #{led.sample}"
             when "Neutral"
               then "#{nd.sample}, #{nd.sample}, #{nd.sample}"
             when "Neutral Good"
               then "#{ngd.sample}, #{ngd.sample}, #{ngd.sample}"
             when "Neutral Evil"
               then "#{ned.sample}, #{ned.sample}, #{ned.sample}"
             when "Chaotic Good"
               then "#{cgd.sample}, #{cgd.sample}, #{cgd.sample}"
             when "Chaotic Neutral"
               then "#{cnd.sample}, #{cnd.sample}, #{cnd.sample}"
             when "Chaotic Evil"
               then "#{ced.sample}, #{ced.sample}, #{ced.sample}"
             else $pc['deity'].sample
             end
             weapon = case pclasscase
             when "barbarian", "fighter",\
                  "paladin", "ranger",\
                  "cavalier", "gunslinger"\
                  "magus", "vigilante",\
                  "bloodrager", "skald",\
                  "slayer", "swashbuckler",\
                  "warpriest", "hunter"
               then $pc['simpmart'].sample
             when "cleric", "sorcerer",\
                  "alchemist", "oracle",\
                  "summoner", "witch", "arcanist"
               then $pc['simple'].sample
             when "bard"
               then $pc['bardwep'].sample
             when "inquisitor"
               then $pc['inquisitor'].sample
             when "rogue"
               then $pc['roguewep'].sample
             when "brawler"
               then $pc['brawlerwep'].sample
             when "investigator"
               then $pc['investigatorwep'].sample
             when "druid"
               then $pc['druidwep'].sample
             when "monk"
               then $pc['monkwep'].sample
             when "wizard"
               then $pc['wizardwep'].sample
              else $pc['simpmart'].sample
             end

  event.channel.send_embed do |e|
  #e.thumbnail = { url: event.server.icon_url }
  e.description = 'Randomly generated character sheet'
  e.add_field name: 'Class', value:"A #{align} #{race.sample} #{pclasscase}"\
                                    " #{stats.sample}", inline: true
  e.add_field name: "#{gender} may follow", value: deity, inline: true
  e.add_field name: 'Names', value: "`#{FantasyNames.sample}`,"\
                                    "`#{FantasyNames.sample}`,"\
                                    "`#{FantasyNames.sample}`",inline: true
  e.add_field name: 'Physical description', value: "#{gender} has #{hairLength.sample}"\
                                             " #{hair.sample} hair, #{bodytype.sample}"\
                                                          " body and #{height.sample}."\
                                                          " #{pronoun} weapon of choice is #{weapon}.", inline: true
  end
end

bot.command(:scene,
            description: "Get a random scene to draw/paint!",
            usage: '~scene') do |event|
  event << "You should draw #{Subject.sample} #{Weather.sample} #{TimeofDay.sample} in #{Seasons.sample}"
end

bot.command(:selfie,
            description: "See my selfies of me, DrawBot AKA Eris!",
            usage: '~selfie') do |event|
  event << "Have a picture of your favourite bot! ;)"\
           "#{Selfie.sample}"
           "Here's an album of all my selfies <http://imgur.com/a/8lWRt>"
end




bot.command(:c,
            description: "Generates completel:y random colours") do |event|
              hex1 = SecureRandom.hex(3)
              url = "https://dummyimage.com/75x75/#{hex1}&text=#{hex1}"
              hex2 = SecureRandom.hex(3)
              url2 = "https://dummyimage.com/75x75/#{hex2}&text=+#{hex2}"
              event.channel.send_embed do |e|
              #e.description = 'General Server-wide information'
              e.image = { url: "#{url}", value: "\u200b", inline: true }
              e.thumbnail = { url: "#{url2}", inline: true }
              e.add_field name: "\u200b",
                value: "Your colours are #{hex1} and #{hex2}", inline: true
              end
            end

            #{ |e, c|  ; e.channel.send_embed { |em| em.image = { url: url } ; em.color = c }

#COLOUR COMMAND
bot.command(:colour,
             description: "Generate a random set of complementary colours!",
             usage: '~colour') do |event|
  event << "Your complementary colours are"
  event << "#{Compcolour.sample}"
  event << "Oooh they're so pretty~"
end

#COLOUR COMMAND
bot.command(:compcolor,
             description: "Generate a random set of complementary colours, you yankee!",
             usage: '~color') do |event|
  event << "Your complementary colours are"
  event << "#{Compcolour.sample}"
  event << "You yankee"
end

#COLOUR SHADES COMMAND
bot.command(:colourshade,
            description: "Generate shades of a random character",
            usage: '~colourshade') do |event|
  event << "Your colour shades are"
  event << "#{Colourshade.sample}"
  event << "Oooh they're so pretty~"
end

bot.command(:references,
            description: 'Lists artistic reference galleries',
            usage: '~references (topic)') do |event, *args|
              #event.channel.send_embed do |e|
              ##e.thumbnail = { url: event.server.icon_url }
              #e.description = 'Randomly generated character sheet'
              #
              #e.add_field name: ' ', value:" ", inline: true
              #end
  args = args.join(' ')
  unless args.empty?
    #finds the ref listed with the arg you use
    ref = $db['refs'].find { |r| r['title'].casecmp(args).zero? }
    unless ref.nil?
      event.channel.send_embed do |e|
      e.add_field name: "#{ref['title']}", value:"#{ref['url']}", inline: true
      e.footer = { text: $db['refs'].collect { |r| "#{r['title']}" }.join(', ') }
      end

      return
    end
  end
  #this is for when you don't have arguments, to find the list of refs
    event.channel.send_embed do |e|
        e.add_field name: 'I couldn\'t find that reference..',\
        value: "\u200b" ,inline: true
        e.add_field name: 'Here is a list of available references:',\
        value: $db['refs'].collect { |r| "`#{r['title']}`" }.join(', '), inline: true
    end
end

bot.command(:word,
             description: "Generate a random set of words",
             usage: '~word') do |event, *message|
  "You get the following words:
  `#{wordlist.sample}`, `#{wordlist.sample}`, `#{wordlist.sample}`,"\
  " `#{wordlist.sample}`, `#{wordlist.sample}`"
end


bot.command(:graff,
             description: "Generate a random set of words 3-5 characters in length",
             usage: '~graff') do |event|
  "You get the following words:
  `#{graff.sample}`,`#{graff.sample}`, `#{graff.sample}`, "\
  "`#{graff.sample}`,`#{graff.sample}`,"
end

bot.command(:prompt,
             description: "Generate a random story prompt",
             usage: '~prompt') do |event, *message|
             thing = ["scary", "creepy", "uplifting", "happy", "melancholy", "exciting",
                 "Ambiguous", "Ambivalent", "Apathetic", "Cynical", "Disturbing", "Diverse",
                 "Dominant", "Exuberant", "Humourous", "Hysterical", "Insensitive", "Jovial",
                 "Lackadaisical", "Livid", "Morose", "Precocious", "Raucous", "Relaxed",
                 "Sarcastic", "Sensitive", "Sleepy", "Soothed", "Vivacious"]
  "You get the following story prompt: `#{prompt.sample}` Make it #{thing.sample}"
end


bot.command(:rufs,
            description: 'Lists artistic reference galleries',
            usage: '~references (topic)') do |event, *args|
              #event.channel.send_embed do |e|
              ##e.thumbnail = { url: event.server.icon_url }
              #e.description = 'Randomly generated character sheet'
              #
              #e.add_field name: ' ', value:" ", inline: true
              #end
  args = args.join(' ')
  unless args.empty?
    #finds the ref listed with the arg you use
    ref = $db['reffz'].find { |r| r['group'].casecmp(args).zero? }
    unless ref.nil?
      event.channel.send_embed do |e|
      e.add_field name: "#{ref['group']}", value:"#{['refs'].map { "#{['title']}" + "#{['url']}"}.join(', ')}", inline: true
      e.footer = { text: $db['reffz'].collect { |r| "#{r['group']}" }.join(', ') }
      end

      return
    end
  end
  #this is for when you don't have arguments, to find the list of refs
    event.channel.send_embed do |e|
        e.add_field name: 'I couldn\'t find that reference..',\
        value: "\u200b" ,inline: true
        e.add_field name: 'Here is a list of available references:',\
        value: $db['reffz'].collect { |r| "`#{r['group']}`" }.join(', '), inline: true
    end
end




#NAMES COMMANDS
bot.command(:names,
             description: "Generate 8 random names from a 1990 census, 4 male, 4 female",
             usage: '~names') do |event|
  event << "#{event.user.mention}, your randomly generated names are;"
  event << ""
  event << "**Male Names**"
  event << "`#{Malenames.sample}` `#{Malenames.sample}`"\
           " `#{Malenames.sample}` `#{Malenames.sample}`"
  event << "**Female Names**"
  event << "`#{Femalenames.sample}` `#{Femalenames.sample}` "\
           " `#{Femalenames.sample}` `#{Femalenames.sample}`"
  event.message.delete
end

bot.command(:fantasyname,
             description: "Generate a random fantasy name!",
             usage: '~fantasyname') do |event|
  event << "#{event.user.mention}, your random fantasy name is `#{FantasyNames.sample}`"
  event.message.delete
end



bot.command(:refs,
            description: "Get the reference of a fellow artist!",
            usage: '~refs @user') do |event, mention|
  user = $db['users'][event.bot.parse_mention(mention).id]

  if user.nil?
    event << "User not found.. sorry sweetheart!"
    return
  end

  if user['refs'].nil?
    event << "They don't have a ref, yet"
    return
  end

  event << "#{user['name']}'s refs:"
  user['refs'].each { |x| event << x }
  nil
end

bot.command(:addref,
            description: 'Add a reference for yourself or your character!',
            usage: "`~addref (URL)`") do |event, url|
            def save
              file = File.open("db.yaml", "w")
              file.write($db.to_yaml)
            end
  user = $db['users'][event.user.id]
         if user.nil?
       $db['users'][event.user.id] = Hash["name" => event.user.display_name, "refs" => [], "hearts" => 0, "salt" => 0, "stipend" => 25]
           event << "User added"
         end
  user = $db['users'][event.user.id]
       user['refs'] << url.to_s
       event << "Ref added! :wink:"
       save
       nil
end

bot.command(:reg) do |event|
          def save
            file = File.open("db.yaml", "w")
            file.write($db.to_yaml)
          end
begin
  user = $db['users'][event.user.id]
      if user == true
      event << "You're already registered sweetheart."
      end
    if user.nil?
      $db['users'][event.user.id] = Hash["name" => event.user.display_name, "refs" => [], "hearts" => 0, "salt" => 0, "stipend" => 25]
      event << "User added! You now have `0 HEARTS`, `0 SALT`, `25 STIPEND`, and can add refs!"
      save
      nil
    end
rescue => e
  puts e
end
end



#-------------EVENTS---------#

bot.message(with_text: '/o/') do |event|
  event.respond '\o\ '
end

bot.message(contains:/(sparkl)|(sparkling)|(sparkled)/i) do |event|
  event.respond '༼∩ •́ ヮ •̀ ༽⊃━☆ﾟ. * ･ ｡ﾟ'
end



#bot.message(start_with:/(should i.+\?)|(should.+\?)|(can.+\?i)|(can.+\?)|(will.+\?)|(is.+\?)|(do.+\?)/i) do |event|
#        event.respond ["Yea, #{event.user.display_name} :thumbsup:",
#                       "Nah, #{event.user.display_name} :thumbsdown:",
#                       "Dunno, #{event.user.display_name} :open_hands:"].sample
#end


#-------------SILLY COMMANDS---------#


bot.command(:'8ball') do |event, *message|
  message = message.join(' ')
  fortune = EIGHTBALL.select { |e| !e['fortune'].empty? }.sample['fortune']
  event << "#{event.user.mention} `#{message}`: #{fortune}"
end

bot.command(:eris) do |event, *message|
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

bot.command(:zii) do |event, *message|
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

bot.command :roll do |event, roll|
  roll = roll.split('d').map(&:to_i)
  roll = roll[0].times.collect { |x| rand(1..roll[1]) }
  total = roll.inject(0){|sum,x| sum + x }
  event << "#{event.user.display_name} throws their dice down and rolls `#{roll.join(', ')} = #{total}`"
end

bot.command(:pick,
             description: 'Use Drawbot to choose things for you',
             usage: "~pick choice 1, choice 2" ) do |event, *message|
  pickmessage = message.join(' ').split(',')
  event << "#{event.user.mention}, I choose;"
  event << "#{pickmessage.sample}"
end

bot.command(:wave) do |event, *message|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
  next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
   message = message.join(' ')
   event << "#{event.user.display_name} waves #{message}"
   event.message.delete
end

bot.command(:boop) do |event, *message|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
  next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
   message = message.join(' ')
   event << "#{event.user.display_name} #{BoopAction.sample} boops #{message}"
   event.message.delete
end

bot.command(:slap) do |event, *message|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
  next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
   message = message.join(' ')
   event << "#{event.user.display_name} #{BoopAction.sample} slaps #{message}"
   event.message.delete
end

bot.command(:spank) do |event, *message|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
  next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
   message = message.join(' ')
   event << "#{event.user.display_name} #{BoopAction.sample} spanks #{message}"
   event.message.delete
end

bot.command(:rub) do |event, *message|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
  next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
   message = message.join(' ')
   event << "#{event.user.display_name} #{BoopAction.sample} rubs #{message}"
   event.message.delete
end

bot.command(:grope) do |event, *message|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
  next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
   message = message.join(' ')
   event << "#{event.user.display_name} #{BoopAction.sample} gropes #{message}"
   event.message.delete
end

bot.command(:hug) do |event, *message|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
  next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
   message = message.join(' ')
   event << "#{event.user.display_name} #{BoopAction.sample} hugs #{message}"
   event.message.delete
end

bot.command(:hump) do |event, *message|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
  next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
   message = message.join(' ')
   event << "#{event.user.display_name} #{BoopAction.sample} humps #{message}"
   event.message.delete
end

bot.command(:bite) do |event, *message|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
  next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
   message = message.join(' ')
   event << "#{event.user.display_name} #{BoopAction.sample} bites #{message}"
   event.message.delete
end

bot.command(:smack) do |event, *message|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
  next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
   message = message.join(' ')
   event << "#{event.user.display_name} #{BoopAction.sample} smacks #{message}"
   event.message.delete
end

bot.command(:punch) do |event, *message|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
  next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
   message = message.join(' ')
   event << "#{event.user.display_name} #{BoopAction.sample} punches #{message}"
   event.message.delete
end

bot.command(:noogie) do |event, *message|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
  next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
   message = message.join(' ')
   event << "#{event.user.display_name} gives #{message} a noogie"
   event.message.delete
end

bot.command(:smell) do |event, *message|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
  next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
   message = message.join(' ')
   event << "#{event.user.display_name} smells #{message}"
   event.message.delete
end

bot.command(:lick) do |event, *message|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
  next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
   message = message.join(' ')
   event << "#{event.user.display_name} #{BoopAction.sample} licks #{message}"
   event.message.delete
end

bot.command(:kick) do |event, *message|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
  next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
   message = message.join(' ')
   event << "#{event.user.display_name} #{BoopAction.sample} kicks #{message}"
   event.message.delete
end

bot.command(:chop) do |event, *message|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
  next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
   message = message.join(' ')
   event << "#{event.user.display_name} #{BoopAction.sample} karate chops #{message}"
   event.message.delete
end

bot.command(:squeeze) do |event, *message|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
  next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
   message = message.join(' ')
   event << "#{event.user.display_name} #{BoopAction.sample} squeezes #{message}"
   event.message.delete
end

bot.command(:arrest) do |event, *message|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
  next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
   message = message.join(' ')
   event << "#{event.user.display_name} #{BoopAction.sample} arrests #{message}"
   event.message.delete
end

bot.command(:sharpie) do |event, *message|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
  next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
   message = message.join(' ')
   event << "#{event.user.display_name} draws all over #{message} with a sharpie"
   event.message.delete
end

bot.command(:dance) do |event, *message|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
  next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
   message = message.join(' ')
   event << "#{event.user.display_name} #{BoopAction.sample} dances with #{message}"
   event.message.delete
end

bot.command(:pat) do |event, *message|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
  next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
   message = message.join(' ')
   event << "#{event.user.display_name} #{BoopAction.sample} pats #{message}"
   event.message.delete
end

bot.command(:pet) do |event, *message|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
  next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
   message = message.join(' ')
   event << "#{event.user.display_name} #{BoopAction.sample} pets #{message}"
   event.message.delete
end

bot.command(:sit) do |event, *message|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
  next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
   message = message.join(' ')
   event << "#{event.user.display_name} #{BoopAction.sample} sits on #{message}"
   event.message.delete
end

bot.command(:tease) do |event, *message|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
  next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
   message = message.join(' ')
   event << "#{event.user.display_name} #{BoopAction.sample} teases #{message}"
   event.message.delete
end

bot.command(:whip) do |event, *message|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
  next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
   message = message.join(' ')
   event << "#{event.user.display_name} #{BoopAction.sample} whips #{message}"
   event.message.delete
end

bot.command(:murder) do |event, *message|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
  next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
   message = message.join(' ')
   event << "#{event.user.display_name} #{BoopAction.sample} murders #{message}"
   event.message.delete
end

bot.command(:wink) do |event, *message|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
  next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
   message = message.join(' ')
   event << "#{event.user.display_name} #{BoopAction.sample} winks at #{message}"
   event.message.delete
end

bot.command(:kiss) do |event, *message|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
  next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
   message = message.join(' ')
   event << "#{event.user.display_name} gives #{message} a kiss :kiss:"
   event.message.delete
end

bot.command(:lean) do |event, *message|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
  next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
   message = message.join(' ')
   event << "#{event.user.display_name} #{BoopAction.sample} leans on #{message}"
   event.message.delete
end

bot.command(:squish) do |event, *message|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
  next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
   message = message.join(' ')
   event << "#{event.user.display_name} squishes #{message} Quick, grab the broom!"
   event.message.delete
end

bot.command(:pokeball) do |event, *message|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
  next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
   message = message.join(' ')
   catch = ['caught', 'missed', 'missed', 'missed', 'missed'].sample
   event << "#{event.user.display_name} throws a pokeball at #{message}, #{event.user.display_name} #{catch} #{message}"
end

bot.command(:nick,
            description: "Give yourself a random name, or choose one",
            usage: '~nick (optional name) and clear your name with ~nick clear') do |event, *nick|
  nick = nick.join ' '
  names = ($db['malenames'] + $db['femalesnames'] + $db['fantasynames'] + $db['DrawTopic'])
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
  rescue
    'Sorry sweetheart, something went wrong. :cry:'
  end
end

bot.command(:doit) do |event|
  break unless event.server.id == 175579371975868416
  response = "http://i.imgur.com/grXCyq2.png"
  event << response
end

bot.command(:gimme) do |event|
  break unless event.server.id == 175579371975868416
  response = "http://i.imgur.com/A9UWyst.png"
  event << response
end

#TIMEOUT
bot.command(:bad) do |event, *message|
  break unless event.user.id == 132893552102342656
  message = message.join(' ')
  event << "#{event.user.display_name} throws #{message} into timeout"
end

bot.command(:spray) do |event, *message|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
  next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
   message = message.join(' ')
   event << "#{event.user.display_name} sprays #{message} with a #{WaterContainer.sample}"
   event.message.delete
end



bot.command(:snek) do |event|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
  next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
   event << "#{Snake.sample}"
end

bot.command(:pun) do |event|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
  next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
   event << "#{Puns.sample}"
end

bot.command(:told) do |event|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["spam", "unlocksfw"]
  next event.respond "I need the `playful` or `spam` role for that, silly" if check.empty?
   event << Told
end

bot.command(:rekt) do |event|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["spam", "unlocksfw"]
  next event.respond "I need the `spam` or `unlocksfw` role for that, silly" if check.empty?
   event << Rekt
end


bot.command(:joke,
            description: "Tells an offensive joke.",
            usage: '~joke') do |event|
              check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["offensive", "unlocknsfw"]
              next event.respond "I need the `offensive` or `unlocknsfw` role for that, silly" if check.empty?
   event << "#{DirtyJoke.sample}"
end

#LEWD COMMAND
bot.command(:'lewd') do |event|
  event <<  "#{Lewd.sample}"
end



bot.command(:texas) do |event|
  break unless event.server.id == 175579371975868416
  event << "https://puu.sh/oQk1b/ddf195310c.png"
end

bot.command(:salt) do |event|
  break unless event.server.id == 175579371975868416
  event << "https://puu.sh/pwPPr/c4ea4b2e93.jpg"
end

bot.command(:orangyheart) do |event|
  break unless event.server.id == 175579371975868416
  event << "http://puu.sh/pCzpn/8f0f140aa1.jpg"
end



bot.command(:pout) do |event|
   event << "#{Pout.sample}"
end


bot.bucket :e621, limit: 3, time_span: 30, delay: 10
bot.command(:e621, bucket: :e621, rate_limit_message: 'Calm down sweetheart! I can\'t keep up with the lewd!',
            description: "Search for an image on e621.net",
            usage: '~e621 (search_term)') do |event, *search|
    check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["e621", "unlocknsfw"]
    next event.respond "I need the `e621` or `unlocknsfw` role for that, silly" if check.empty?
    search = search.join('%20')
    next event.respond 'Please give me something to search for' if search.empty?
      base_url = 'https://e621.net/post/index/1/'
      e621 = Nokogiri::HTML RestClient.get(base_url + search)
      pictures = e621.css('.thumb').map do |x|
      x = "https://e621.net#{x.css('a').attr('href')}"
      end
        next event.respond 'I couldn\'t find anything, sorry hun.' if pictures.empty?
        bigimage_page = Nokogiri::HTML RestClient.get(pictures.sample)
        bigimage = bigimage_page.css('.content').css('img').map do |x|
          x.attr('src')
        end
        event.respond bigimage[1]
end

bot.bucket :r34, limit: 3, time_span: 30, delay: 10
bot.command(:r34,
             description: "Search for an image on R34 Paheal",
             usage: `~r34 (search term)`) do |event, *search|
  #If the bot doesn't have the required role; command won't run
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["r34", "unlocknsfw"]
  next event.respond "I need the `r34` or `unlocknsfw` role for that, silly" if check.empty?
    begin
      next event.respond 'Please give me something to look for' if search.empty?
      #The URL the search starts with
      base_url = 'http://rule34.paheal.net/post/list/'
      #Tacks the search arg onto the end of the base_url
      rule34 = Nokogiri::HTML RestClient.get(base_url + search.join('_') + '/1')
      #Uses x to grab the URL from the css
      pictures = rule34.css('.shm-thumb').map do |x|
        #This produces the img URL from pictures
        x = x.css('a')[1].attr('href')
        #y = "https://rule34.paheal.net#{x.css('a')[0].attr('href')}" # This gets the post not a direct image
      end
      next event.respond 'No pictures found' if pictures.empty?
      #Spits out the randomized end result
      event.respond pictures.sample
    rescue
      event.respond "Couldn't find anything"
    end
end


bot.command(:echo) do |event|
    break unless event.user.id == 132893552102342656
      event << "Olly olly oxen free! `#{Time.now - event.timestamp} ms`"
end

#http://apidock.com/ruby/DateTime/strftime
bot.command(:submit,
             description: "Submit to the gallery!",
             usage: "`~submit #channel (link)`") do |event, channel, url, *message|
     next event.respond('I need a channel to post to, sweetheart!') unless /\d{18}/.match(channel)
     next event.respond('I need a link, hun!') unless /(http|https):\/\/(.)*/i.match(url)
   num = Time.now.strftime("%Y%j%H%M%S")
  begin
   event.bot.channel(channel[2..-1]).send_message("**Submission number** `#{num}`"\
   "\n#{event.user.mention} posted their art #{url}"\
   "\n#{message.join(" ")}")
  rescue
    "Sorry sweety, something went wrong!"
  end
end




############################


bot.command(:serverstat,
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
      value: "#{event.server.online_members.count}", inline: true
    e.add_field name: 'Total Members',
      value: "#{event.server.member_count}", inline: true
    e.add_field name: 'Amount of Roles',
      value: event.server.roles.count, inline: true
    e.add_field name: 'Amount of Channels',
      value: event.server.channels.count, inline: true
    e.add_field name: 'Banned Members',
      value: event.server.bans.count, inline: true
    e.add_field name: 'Verification Level',
      value: event.server.verification_level.upcase, inline: true
    e.add_field name: 'Custom emojis on server?',
      value: event.server.any_emoji?, inline: true
  end
end
#litterally stolen from Cyan
bot.command(:userstat,
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


#Litterally stolen from Cyan No Shame (https://github.com/Cyan101/sapphire/blob/master/modules/reactions.rb)

bot.command :poll, help_available: true,
        description: "Does a poll that ends after 2min or the set time, can have up to 5 options seperated with a \'-\'",
        usage: "poll 20min <option 1> - <option 2>` (from 1min to 60min don't forget the 'min')`", min_args: 1 do |event, *message|
       reactions = %w(🇦 🇧 🇨 🇩 🇪)
       time = '2m'
       next event.respond 'I can only count to 60min :sweat: sorry' unless message[0].strip =~ /^[1-5]\dm|^60m|^\dm/i
       time = message.shift if message[0].strip =~ /^[1-5]\dm|^60m|^\dm/i
       message = message.join(' ')
       options = message.split('-')
       next event.respond 'I can only count up to 5 options :stuck_out_tongue_closed_eyes:' if options.length > 5
       next event.respond 'I need at least one option :thinking:' if options.empty?
       eachoption = options.map.with_index { |x, i| "#{reactions[i]}. #{x.strip.capitalize}" }
       output = eachoption.join("\n")
       poll = event.respond "Starting poll for: (Expires in: #{time})\n#{output}"
       reactions[0...options.length].each do |r|
         poll.react r
       end
       time = time.to_i * 60
       while time > 0
         sleep 30
         time -= 30
         poll.edit "Starting poll for: (Remaining time: #{time.to_f / 60}m)\n#{output}"
       end
       values = event.channel.message(poll.id).reactions.values
       winning_score = values.collect(&:count).max
       winners = values.select { |r| r.count == winning_score if reactions.include? r.name }
       result = ''
       result << 'Options: '
       reactions[0...options.length].each_with_index do |x, i|
         result << "#{x} = `#{options[i].strip.capitalize}`  "
       end
       result << "\n"
       result << 'Winner(s):'
       winners.each do |x|
         result << " #{x.name} with #{x.count - 1} vote(s)"
       end
       # reactions[0...options.length].each_with_index do |x, i|
       # result << "#{x} `#{options[i].strip.capitalize}` had #{event.channel.message(poll.id).reactions[x].count} vote(s)  "
       # end
       # result << "\n"
       event.respond result
     end
#-----------BANK AND CURRENCY

#get bank amount
#bot.bucket :bank, limit: 1, time_span: 30, delay: 30
bot.command(:bank, bucket: :bank, rate_limit_message:'I can\'t spread the wealth that fast!',
             description: "Fetches your balance, or @user's balance") do |event, mention|
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["banker", "unlocksfw"]
  next event.respond "I need the `banker` or `unlocksfw` role for that, silly" if check.empty?
     def save
       file = File.open("db.yaml", "w")
       file.write($db.to_yaml)
     end
   begin
   user = $db['users'][event.user.id]
   if user == true
   event << "You're already registered sweetheart."
   end
   if user.nil?
   $db['users'][event.user.id] = Hash["name" => event.user.display_name, "refs" => [], "hearts" => 0, "salt" => 0, "stipend" => 25]
   event << "User added! You now have `0 HEARTS`, `0 SALT`, `25 STIPEND`, and can add refs!"
   save
   nil
   end
   rescue => e
   puts e
   end

   if mention.nil?
     mention = event.user.id.to_i
   else
     mention = event.message.mentions.at(0).id.to_i
   end

    #load user from $db, report if user is invalid or not registered.
    user = $db["users"][mention]
    if user.nil?
      event << "User does not exist, sorry sweety."
      return
    end

    #report bank
    total = user['hearts'] + user['salt']
    percent_hearts = (user['hearts'].to_f / total.to_f) * 100.0
    percent_hearts = percent_hearts.round(2)
    percent_salty = (user['salt'].to_f / total.to_f) * 100.0
    percent_salty = percent_salty.round(2)
    event << "You are **#{percent_hearts}%** lovely :kissing_heart: and **#{percent_salty}%** salty! :unamused:"
    event << ""
    event << "Heart balance: #{user['hearts']}"
    event << "Salt balance: #{user['salt']}"
    event << "Stipend balance: #{user['stipend']}"

   nil
end





#set bank amount
bot.command(:setbank, min_args: 3, description: "sets @user's bank and stipend balance") do |event, mention, hearts, salt, stipend|
  break unless event.channel.id == DEVCHANNEL
  def save
    file = File.open("db.yaml", "w")
    file.write($db.to_yaml)
  end
   hearts = hearts.to_i
   salt = salt.to_i
   stipend = stipend.to_i

  #update $db with requested values
   user = $db['users'][event.bot.parse_mention(mention).id]
   user['salt'] = salt
   user['hearts'] = hearts
   user['stipend'] = stipend

  #notification
  event << "Updated! :wink:"

  save
  nil
end




#------GIVE COMMAND
bot.command(:give, min_args: 3,
            description: "give currency",
            usage: '~give @user # hearts or salt') do |event, to, value, type|
  next event.respond "I need the `banker` role for that, silly" unless
  check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["banker", "unlocksfw"]
  next event.respond "I need the `banker` or `unlocksfw` role for that, silly" if check.empty?
   value = value.to_i
   def save
     file = File.open("db.yaml", "w")
     file.write($db.to_yaml)
   end
      #checks to make sure people aren't stealing (giving negative values)
   next "No negatives allowed" if value < 1
      #pick up user
    fromUser = $db["users"][event.user.id]

    #return if invalid user
    if fromUser.nil?
      event << "User does not exist :x:"
      return
    end

    #check if they have enough first
    if (fromUser["stipend"] - value) < 0
      event << "You do not have enough currency to make this transaction. :disappointed_relieved:"
      return
    end

    if bot.parse_mention(to).id == event.bot.profile.id
      event << "Is that all you have to offer, hun?"
      event << "https://i.imgur.com/SZAppZR.jpg"
      return
    end

    #pick up user to receive currency
    toUser = $db["users"][event.bot.parse_mention(to).id]

    #check that they exist
    if toUser.nil?
      event << "User does not exist :x:"
      return
    end

    if fromUser == toUser
      event << "You can't give yourself things, sweety."
     return
    end

  #transfer currency
  #remove from stipend
  fromUser["stipend"] -= value

  #give toUser the desired currency
  if type == 'salt'
      toUser['salt'] += value
    elsif type == 'hearts'
      toUser['hearts'] += value

  else
    event << "Hey hun? Choose `salt` or `hearts`, I can't do that for you!"
    return
  end

  #notification
  event << "**#{event.user.display_name}** awarded **#{event.message.mentions.at(0).on(event.server).display_name}** with **#{value.to_s} #{type}** :yum:"

  save
    nil

end



bot.command(:setstipend, min_args: 1, description: "sets all users stipend values") do |event, value|
  break unless event.channel.id == DEVCHANNEL
  def save
    file = File.open("db.yaml", "w")
    file.write($db.to_yaml)
  end
  value = value.to_i
  $db["users"].each do |id, data|
    data["stipend"] = value

  end
    $db['users'][132893552102342656]['stipend'] = 10000
  event << "All stipends set to `#{value.to_s}`"

  save
  nil
end

bot.command :say do |event, *message|
   break unless event.channel.id == DEVCHANNEL
    message = message.join(' ')
    event.bot.channel(175579371975868416).send_message(message)
end

bot.command(:todo,
             help_available: false) do |event, *message|
   break unless event.user.id == 132893552102342656
    message = message.join(' ')
    num = Time.now.strftime("%Y%j%H%M%S")
    event.bot.channel(322615736717672450).send_message("Ref number #{num} - #{message}")
    "New thing added to your To Do list hun! Ref Number #{num}"
end


bot.command :sayoify do |event, *message|
   break unless event.channel.id == DEVCHANNEL
    message = message.join(' ')
    event.bot.channel(153108535239114752).send_message(message)
end

bot.command :sayccmain do |event, *message|
   break unless event.channel.id == DEVCHANNEL
    message = message.join(' ')
    event.bot.channel(153107239597506560).send_message(message)
end


bot.command :announce do |event, *message|
   break unless event.channel.id == DEVCHANNEL
    message = message.join(' ')
        event.bot.servers.values.each { |s| s.default_channel.send_message \
        "Hello #{s.name}. #{message}"}
end



#------------Eval-----------#
bot.command(:eval,
             help_available: false) do |event, *code|
  break unless event.user.id == 132893552102342656
  begin
    eval code.join(' ')
  rescue => e
    "An error occured, but I believe you can do it!  ```#{e}```"
  end
end

bot.command(:getdb) do |event|
  break unless event.channel.id == DEVCHANNEL
  file = File.open('db.yaml')
  event.channel.send_file(file)
end

CHANNELS = [
       175579371975868416
     ]

     bot.message(in: CHANNELS) do |event|
       next unless rand(1..200) == 1

       meme = event.message.content
                           .chars
                           .map { |c| [c.downcase, c.upcase].sample }
                           .join

       m = event.channel.send_embed(
         meme,
         {
           image: {
             url: 'http://i0.kym-cdn.com/entries/icons/original/000/022/940/spongebobicon.jpg'
           }
         }
       )

       sleep 25

     m.delete
     end




bot.run

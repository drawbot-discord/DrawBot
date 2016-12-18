require 'discordrb'
require 'yaml'
require 'rest_client'
require 'rufus-scheduler'
require 'nokogiri'
require 'rest-client'
require 'json'

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
puts 'meme'
puts ' '
puts ' '
puts ' '

#-------YAML THINGS------#

$db = YAML.load(File.read('db.yaml'))

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
Race = $db['race']
PClass = $db['class']
Stats = $db['stats']
Align = $db['align']
Study = $db['StudyDrawTopic']
Colourshade = $db['shadecolour']
References = $db['refs']
Malenames = $db['malenames']
Femalenames = $db['femalesnames']
FantasyNames = $db['fantasynames']
Hair = $db['hair']
Deity = $db['deity']
DirtyJoke = $db['dirtyjoke']
BodyType = $db['bodytype']
Weather = $db['weather']
Seasons = $db['seasons']
TimeofDay = $db['timeofday']
Subject = $db['subject']

DEVCHANNEL = 222032313154928640
DRAWCHANNEL = 175579371975868416



bot = Discordrb::Commands::CommandBot.new token: $db['token'], client_id: 186636165938413569, prefix: '~'

#restart bot
bot.command(:restart,
            description: "restarts the bot") do |event|
        break unless event.user.id == 132893552102342656
      event.channel.send_message("Sure thing hun!")
      event.channel.send_message("Restart issued.. :wrench:")
    bot.stop
  exit
end


bot.ready do |event|
  event.bot.send_message(DEVCHANNEL, "Drawbot online! Let's get some art done!")
  avatar = File.open('media/avatar.jpg','rb')
  event.bot.profile.avatar = avatar
  event.bot.game = "~commands"
  event.bot.send_message(DEVCHANNEL, "Number of servers I'm in; `#{event.bot.servers.count}` and they are;")
  event.bot.send_message(DEVCHANNEL, event.bot.servers.collect { |_, s| s.name }.join(', '))
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


bot.command(:commands) do |event|
  event << "<https://github.com/LeggoMyEcho/DrawBot/wiki/Commands>"
end



bot.command(:info,
             description: 'Get some general info about drawbot!') do |event|
  response = "Hey there, my name is DrawBot AKA Eris. I'm hosted by `Echo#5248` and worked on by `Echo#5248` and `Lune#2639`\n
If you have any questions or issues you can join my server `discord.gg/u3a2Ck9`\n
My github home can be found here: `github.com/LeggoMyEcho/DrawBot` and my invite link is `discordapp.com/oauth2/authorize?client_id=186636037001445377&scope=bot`
Use `~commands` to find out what I can do for you!"
  event << response
end

#------------ART COMMANDS-----------#

bot.command(:draw,
            description: 'Generate a random thing to draw!',
            usage: "~draw") do |event|
  event << "You should draw #{DrawTopic.sample}"
end

bot.command(:drawlewd,
             description: "Generate a random lewd thing to draw!",
             usage: '~drawlewd') do |event|
   next event.respond "I need the `lewd` role for that, silly" unless
   event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'lewd'
  event << "You should draw something #{DrawComboTopic.sample} #{LewdDrawTopic.sample}"
end

bot.command(:drawcombo,
             description: "Generate a more random thing to draw!",
             usage: '~drawcombo') do |event|
  event << "You should draw something #{DrawComboTopic.sample} #{NormalDrawTopic.sample}"
end

bot.command(:drawfaglewd) do |event|
  break unless event.channel.id == DRAWCHANNEL
  event << "You must draw #{Artists.sample} #{LewdDrawFagTopic.sample}"
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
             description: "Generate a random female image as a drawing reference (NSFW)",
             usage: '~fpose') do |event|
      event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'nsfw'
   event.bot.profile.on(event.server).role? role
  event << "The pose you get is #{Fpose.sample}"
end

bot.command(:poses,
             description: "Get two lists of poses to draw from! (Use ~roll # to choose)",
             usage: '~poses') do |event|
  event << "`~roll 98`\nhttps://puu.sh/oNXxK/474217250e.jpg\n`~roll 20`\nhttps://puu.sh/oNxer/cb15424c85.jpg"
end

bot.command([:randomchar, :pc],
             description: "Generate a random fantasy character (Pathfinder/DnD)",
             usage: '~randomchar') do |event|
  Gender = ["He", "She"].sample
  HairLength = ["long", "short", "thick", "thin"]
  Height = ["is shorter than most of their kind", "is taller than most of their kind", "is of average height"]
  event << "Your randomly generated fantasy character is a;"
  event << " "
  event << "#{Align.sample} #{Race.sample} #{PClass.sample}, #{Stats.sample}"
  event << "#{Gender} may follow `#{Deity.sample}`, `#{Deity.sample}`,"\
                                 " `#{Deity.sample}`, or `#{Deity.sample}`"
  event << "Possible names are `#{FantasyNames.sample}` `#{FantasyNames.sample}`"\
                               " `#{FantasyNames.sample}` `#{FantasyNames.sample}`"
  event << "#{Gender} has #{HairLength.sample} #{Hair.sample} hair, #{BodyType.sample}"\
           " body and #{Height.sample}."
end

bot.command(:scene,
            description: "Get a random scene to draw/paint!",
            usage: '~scene') do |event|
  event << "You should draw #{Subject.sample} #{Weather.sample} #{TimeofDay.sample} in #{Seasons.sample}"
end


#COLOUR COMMAND
bot.command(:colour,
             description: "Generate a random set of complementary colours!",
             usage: '~colour') do |event|
  event << "Your complementary colours are"
  event << "#{Compcolour.sample}"
  event << "Oooh they're so pretty~"
end

#COLOUR COMMAND
bot.command(:color,
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
  args = args.join(' ')
  unless args.empty?
    #finds the ref listed with the arg you use
    ref = $db['refs'].find { |r| r['title'].casecmp(args).zero? }
    unless ref.nil?
      event << "#{ref['title']}"
      event << "#{ref['url']}"
      return
    end
    event << 'I couldn\'t find that reference..'
  end
  #this is for when you don't have arguments, to find the list of refs
  event << 'List of available references:'
  event << $db['refs'].collect { |r| "`#{r['title']}`" }.join(', ')
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
            usage: "`~addref (URL)`") do |event, *url|
  url = url.join(' ')
  user = $db['users'][event.user.id]
         if user.nil?
           event << "User not found.. sorry hun!"
           return
         end
       user['refs'] << url
       event << "Ref added! :wink:"
       save
       nil
      end
def save
  file = File.open("db.yaml", "w")
  file.write($db.to_yaml)
end



#-------------EVENTS---------#

bot.message(with_text: '/o/') do |event|
  event.respond '\o\ '
end


bot.message(contains:/(sparkl)|(sparkling)|(sparkled)/i) do |event|
  event.respond '༼∩ •́ ヮ •̀ ༽⊃━☆ﾟ. * ･ ｡ﾟ'
end


bot.message(start_with:/(should i.+\?)|(should.+\?)|(can.+\?i)|(can.+\?)|(will.+\?)|(is.+\?)|(do.+\?)/i) do |event|
    break unless event.bot.profile.on(event.server).role? role
    event.respond ["Yea, #{event.user.display_name} :thumbsup:",
                   "Nah, #{event.user.display_name} :thumbsdown:",
                   "Dunno, #{event.user.display_name} :open_hands:"].sample
end


#-------------SILLY COMMANDS---------#


bot.command(:'8ball') do |event, *message|
  message = message.join(' ')
  fortune = EIGHTBALL.select { |e| !e['fortune'].empty? }.sample['fortune']
  event << "#{event.user.mention} `#{message}`: #{fortune}"
end

bot.command(:zii) do |event, *message|
  next event.respond "I need the `zii` role for that, silly" unless
  event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'zii'
   message = message.join(' ')

    index = rand 0..EIGHTBALL.length-1
    fortune = EIGHTBALL[index]['fortune']
    zii = EIGHTBALL[index]['zii']

    event << "#{event.user.mention} #{zii}"
   event << "`#{message}` : #{fortune}"
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
  next event.respond "I need the `playful` role and I need to be able to delete messages" unless
  event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
   message = message.join(' ')
   event << "#{event.user.display_name} waves #{message}"
   event.message.delete
end

bot.command(:boop) do |event, *message|
  next event.respond "I need the `playful` role and I need to be able to delete messages" unless
  event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
   message = message.join(' ')
   event << "#{event.user.display_name} #{BoopAction.sample} boops #{message}"
   event.message.delete
end

bot.command(:slap) do |event, *message|
  next event.respond "I need the `playful` role and I need to be able to delete messages" unless
  event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
   message = message.join(' ')
   event << "#{event.user.display_name} #{BoopAction.sample} slaps #{message}"
   event.message.delete
end

bot.command(:rub) do |event, *message|
  next event.respond "I need the `playful` role and I need to be able to delete messages" unless
  event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
   message = message.join(' ')
   event << "#{event.user.display_name} #{BoopAction.sample} rubs #{message}"
   event.message.delete
end

bot.command(:grope) do |event, *message|
  next event.respond "I need the `playful` role and I need to be able to delete messages" unless
  event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
   message = message.join(' ')
   event << "#{event.user.display_name} #{BoopAction.sample} gropes #{message}"
   event.message.delete
end

bot.command(:hug) do |event, *message|
  next event.respond "I need the `playful` role and I need to be able to delete messages" unless
  event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
   message = message.join(' ')
   event << "#{event.user.display_name} #{BoopAction.sample} hugs #{message}"
   event.message.delete
end

bot.command(:hump) do |event, *message|
  next event.respond "I need the `playful` role and I need to be able to delete messages" unless
  event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
   message = message.join(' ')
   event << "#{event.user.display_name} #{BoopAction.sample} humps #{message}"
   event.message.delete
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
  next event.respond "I need the `playful` role and I need to be able to delete messages" unless
  event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
   message = message.join(' ')
   event << "#{event.user.display_name} sprays #{message} with a #{WaterContainer.sample}"
   event.message.delete
end



bot.command(:snek) do |event|
  next event.respond "I need the `playful` role and I need to be able to delete messages" unless
  event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
   event << "#{Snake.sample}"
end

bot.command(:pun) do |event|
  next event.respond "I need the `pun` role for that, silly" unless
  event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
   event << "#{Puns.sample}"
end

bot.command(:told) do |event|
  next event.respond "I need the `spam` role for that, silly" unless
  event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'spam'
   event << Told
end

bot.command(:rekt) do |event|
  next event.respond "I need the `spam` role for that, silly" unless
  event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'spam'
   event << Rekt
end


bot.command(:joke,
            description: "Tells an offensive joke.",
            usage: '~joke') do |event|
  next event.respond "I need the `offensive` role for that, silly" unless
  event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'offensive'
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
  next event.respond "I need the `e621` role for that, silly" unless
  event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'e621'
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



bot.command(:echo) do |event|
    break unless event.user.id == 132893552102342656
      event << "Olly olly oxen free! `#{Time.now - event.timestamp} ms`"
end




#Creation Corner commands


bot.member_join do |event|
  welcome_channel = event.server.channels.find { |c| c.name == 'green_chat' }
  unless welcome_channel.nil?
    welcome_channel.send_message "#{event.user.mention} has joined!"
  end

  member_role = event.server.roles.find { |r| r.name == 'Blue Members'}
  unless member_role.nil?
    event.user.add_role member_role
  end
end

bot.command(:submit,
             description: 'Submit to the gallery!',
             usage: "~submit (link)") do |event, *url|
   break unless event.channel.id == 215742738644205568
     next event.respond('I need a link hun!') unless 'http://'.match(url.first)
   event << "Submitted, #{event.user.display_name}! :wink:"
   event.bot.channel(215742813831168004).send_message("#{event.user.display_name} posted their art")
   event.bot.channel(215742813831168004).send_message(url)
end


############################


#-----------BANK AND CURRENCY

#get bank amount
bot.bucket :bank, limit: 1, time_span: 30, delay: 30
bot.command(:bank, bucket: :bank, rate_limit_message:'I can\'t spread the wealth that fast!',
             description: "Fetches your balance, or @user's balance") do |event, mention|
  next event.respond "I need the `banker` role for that, silly" unless
  event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'banker'
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
  event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'banker'
   value = value.to_i

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



bot.run

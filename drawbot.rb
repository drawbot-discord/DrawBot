require 'discordrb'
require 'yaml'
require 'rest_client'
require 'rufus-scheduler'

puts 'meme'
puts 'meme'
puts 'meme'
puts 'meme'




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


DEVCHANNEL = 222032313154928640
DRAWCHANNEL = 175579371975868416


bot = Discordrb::Commands::CommandBot.new token: $db['token'], client_id: 186636165938413569, prefix: '~'

#restart bot
bot.command(:restart,
            description: "restarts the bot") do |event|
        break unless event.channel.id == DEVCHANNEL
      event.channel.send_message("Restart issued.. :wrench:")
    bot.stop
  exit
end


bot.ready do |event|
  event.bot.send_message(DEVCHANNEL, "Drawbot online! Let's get some art done!")
  avatar = File.open('media/avatar.jpg','rb')
  event.bot.profile.avatar = avatar
  event.bot.game = "~commands"
  event.bot.send_message(DEVCHANNEL, event.bot.servers.count)
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


##Private commands
#bot.command(:help) do |event|  
#  break unless event.channel.id == DRAWCHANNEL
#  event << "#{commands.join("\n")}"
#end


#public Server
publiccommands = [
  "Drawing Commands",
  " ~draw",
  " ~drawlewd",
  " ~drawcombo",
  " ~colour",
  " ~colourshade",
  " ~outfit",
  " ~pokemon",
  " ~study",
  " ~names",
  "",
  "Fun Commands",
  " wave",
  " ~8ball",
  " ~zii(8ball clone)",
  " ~bad",
  " ~boop",
  " ~slap",
  " ~rub",
  " ~hump",
  " ~spray",
  " ~grope",
  " ~snek",
  " ~lewd",
  " ~roll (default 6, add number after to make larger)",
  " ~pun",
  " ~told",
  " ~pout",
  " ~poses",
  " ~randomchar",
]



#Public commands
bot.command(:commands) do |event|
  event << "#{publiccommands.join("\n")}"
end



bot.command(:info,
             description: 'Get some general info about drawbot!') do |event|
  response = "Hey there, my name is DrawBot AKA Eris. I'm hosted by `Echo#5248` and worked on by `Echo#5248` and `Lune#2639`\n
If you have any questions or issues you can join my server `discord.gg/u3a2Ck9`\n
My github home can be found here: `github.com/LeggoMyEcho/DrawBot` and my invite link is `discordapp.com/oauth2/authorize?client_id=186636037001445377&scope=bot`
Use `~commands` to find out what I can do for you!"
  event << response
end


#-------------SILLY COMMANDS---------#


bot.message(with_text: '/o/') do |event|
  event.respond '\o\ '
end

rate_limiter = Discordrb::Commands::SimpleRateLimiter.new
rate_limiter.bucket :sparkle, delay 10
  bot.message(contains:'sparkle') do |event|
  event.respond '༼∩ •́ ヮ •̀ ༽⊃━☆ﾟ. * ･ ｡ﾟ'
next if rate_limiter.rate_limited?(:'sparkle', event.channel)
event.respond 'Too many sparkles! :scream: '
end

#bot.message(with_text: 'hey') do |event|
#  event.respond 'LISTEN!'
#end

bot.command(:'8ball') do |event, *message|
  message = message.join(' ')
  fortune = EIGHTBALL.select { |e| !e['fortune'].empty? }.sample['fortune']
  event << "#{event.user.mention} `#{message}`: #{fortune}"
end

bot.command(:zii) do |event, *message|
  #break if event.server.id == 175579371975868416
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
  event << "#{event.user.display_name} throws their dice down and roll `#{roll.join(', ')} = #{total}`"
end

bot.command(:wave) do |event, *message|
  message = message.join(' ')
  event << "#{event.user.display_name} waves #{message}"
  event.message.delete
end

bot.command(:boop) do |event, *message|
  message = message.join(' ')
  event << "#{event.user.display_name} #{BoopAction.sample} boops #{message}"
  event.message.delete
end

bot.command(:slap) do |event, *message|
  message = message.join(' ')
  event << "#{event.user.display_name} #{BoopAction.sample} slaps #{message}"
  event.message.delete
end

bot.command(:rub) do |event, *message|
  message = message.join(' ')
  event << "#{event.user.display_name} #{BoopAction.sample} rubs #{message}"
  event.message.delete
end

bot.command(:grope) do |event, *message|
  message = message.join(' ')
  event << "#{event.user.display_name} #{BoopAction.sample} gropes #{message}"
  event.message.delete
end

bot.command(:hug) do |event, *message|
  message = message.join(' ')
  event << "#{event.user.display_name} #{BoopAction.sample} hugs #{message}"
  event.message.delete
end

bot.command(:hump) do |event, *message|
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
  message = message.join(' ')
  event << "#{event.user.display_name} sprays #{message} with a #{WaterContainer.sample}"
end

bot.command(:outfit) do |event|
  event << "#{event.user.mention} your outfit is #{Outfit.sample}"
end


bot.command(:snek) do |event|
  event << "#{Snake.sample}"
end

bot.command(:pun) do |event|
  event << "#{Puns.sample}"
end

bot.command(:told) do |event|
  event << Told
end

bot.command(:rekt) do |event|
  event << Rekt
end

bot.command(:randomchar) do |event|
  event << "Your randomly generated pathfinder character is a"
  event << "#{Align.sample} #{Race.sample} #{PClass.sample}, #{Stats.sample}"
end

#COLOUR COMMAND
bot.command(:colour) do |event|
  event << "Your complementary colours are"
  event << "#{Compcolour.sample}"
end

#COLOUR COMMAND
bot.command(:color) do |event|
  event << "Your complementary colours are"
  event << "#{Compcolour.sample}"
  event << "You yankee"
end

#COLOUR SHADES COMMAND
bot.command(:colourshade) do |event|
  event << "Your colour shades are"
  event << "#{Colourshade.sample}"
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
bot.command(:names) do |event|
  event << "#{event.user.mention}, Your randomly generated names are;"
  event << ""
  event << "**Male Names**"
  event << " `#{Malenames.sample}` `#{Malenames.sample}`"\
           " `#{Malenames.sample}` `#{Malenames.sample}`"
  event << "**Female Names**"
  event << "`#{Femalenames.sample}` `#{Femalenames.sample}` "\
           " `#{Femalenames.sample}` `#{Femalenames.sample}`" 
  event.message.delete
end


#LEWD COMMAND
bot.command(:'lewd') do |event|
  event <<  "#{Lewd.sample}"
end


#---------DRAW COMMANDS-----------#
bot.command(:draw) do |event|
  event << "You should draw #{DrawTopic.sample}"
end

bot.command(:drawlewd) do |event|
  break unless event.channel.id == DRAWCHANNEL
  event << "You should draw something #{DrawComboTopic.sample} #{LewdDrawTopic.sample}"
end

bot.command(:drawcombo) do |event|
  event << "You should draw something #{DrawComboTopic.sample} #{NormalDrawTopic.sample}"
end

bot.command(:drawfaglewd) do |event|
  break unless event.channel.id == DRAWCHANNEL

  event << "You must draw #{Artists.sample} #{LewdDrawFagTopic.sample}"
end

bot.command(:study) do |event|
  event << "The body part you get to study is #{Study.sample}"
end

#this is really cool, i'm glad it was added!
bot.command :pokemon do |event|
  pkmn = JSON.parse(RestClient.get("https://pokeapi.co/api/v2/pokemon/" + rand(1..721).to_s))
  url = JSON.parse(RestClient.get(pkmn['forms'][0]['url']))['sprites']['front_default']
  event << "Your pokemon to draw is: **#{pkmn['name'].split.map(&:capitalize).join(' ')}**"
  event << url
end

bot.command(:fpose) do |event|
  break unless event.channel.id == DRAWCHANNEL
  event << "The pose you get is #{Fpose.sample}"
end

bot.command(:poses) do |event|
  event << "`~roll 98`\nhttps://puu.sh/oNXxK/474217250e.jpg\n`~roll 20`\nhttps://puu.sh/oNxer/cb15424c85.jpg"
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



bot.command(:echo) do |event|
      event << "Olly olly oxen free! `#{Time.now - event.timestamp} ms`"
end

#-----------REFERENCES--------#

#uses the yaml file, add more artists there!


#bot.command :refs do |event, *message|
#    message = message.join(' ')
#    user = Array.new
#
#    #pull users refs from db
#    $db['refs'].each do |key, value|
#        if key.casecmp(message) == 0
#            user = value
#        end
#    end
#
#    #check if array is still empty
#    #if it is, we didn't find a match
#    if user.empty?
#        event << "User not found.. :eyes:"
#        return
#    end
#
#    #output each ref
#    event << "#{message}'s refs:"
#    user.each { |x| event << x }
#    nil
#end


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

############################


bot.command :refs do |event, mention|

  #get user
  user = $db['users'][event.bot.parse_mention(mention).id]

  #check if user isn't in our db
  if user.nil?
    event << "User not found.. :eyes:"
    return
  end

  if user['refs'].nil?
    event << "They don't have a ref, laugh at them!\nhttp://puu.sh/pBzdD/b516b51ba1.jpg"
    return
  end

  #output each ref
  event << "#{user['name']}'s refs:"
  user['refs'].each { |x| event << x }
  nil
end

bot.command(:addref, 
            description: 'Add a reference for yourself or your character!',
            usage: "`~addref (URL)`") do |event, *url|

  url = url.join(' ')

  #get user
  user = $db['users'][event.user.id]

  #check if user isn't in our db
  if user.nil?
    event << "User not found.. :eyes:"
    return
  end

  #add ref to user
  user['refs'] << url

  event << "Ref added! :wink:"

  #save db
  save
  nil
end

def save
  file = File.open("db.yaml", "w")
  file.write($db.to_yaml)
end




#-----------BANK AND CURRENCY

#get bank amount
bot.command(:bank, description: "fetches your balance, or @user's balance") do |event, mention|
break unless event.channel.id == DRAWCHANNEL
  #report our own bank if no @mention
  #pick up user if we have a @mention
  if mention.nil?
    mention = event.user.id.to_i
  else
    mention = event.message.mentions.at(0).id.to_i
  end

  #load user from $db, report if user is invalid or not registered.
  user = $db["users"][mention]
  if user.nil?
    event << "User does not exist http://puu.sh/pGi6t/862de15c71.jpg"
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

    #get integers
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
bot.command(:give, min_args: 3,  description: "give currency") do |event, to, value, type|
break unless event.channel.id == DRAWCHANNEL
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
    event << "Is that all you have to offer, peasant?!"
    event << "http://puu.sh/pBA9k/5801785072.jpg"
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
    event << "You can't give to yourself, so give to me." 
    event << "http://puu.sh/pBAc6/b8710b6a54.png"
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
    event << "Hey buddy! Choose `salt` or `hearts`, I can't do that for you!"
    event << "http://puu.sh/pGb07/d293637db9.jpg"
    return
  end        

  #notification
  event << "**#{event.user.display_name}** awarded **#{event.message.mentions.at(0).on(event.server).display_name}** with **#{value.to_s} #{type}** :yum:"

  save
  nil
end



bot.command(:setstipend, min_args: 1, description: "sets all users stipend values") do |event, value|
  break unless event.channel.id == DEVCHANNEL

  #get integer
  value = value.to_i

  #update all users
  $db["users"].each do |id, data|
    data["stipend"] = value

  end
    $db['users'][132893552102342656]['stipend'] = 10000
  #notification
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





#------Cleverbot





#------------Eval-----------#
bot.command(:eval, help_available: false) do |event, *code|
  break unless event.user.id == 132893552102342656
  begin
    eval code.join(' ')
  rescue => e
    "An error occured :disappointed: ```#{e}```"
  end
end

bot.command :getdb do |event|
  break unless event.channel.id == DEVCHANNEL
  file = File.open('db.yaml')
  event.channel.send_file(file)
end

bot.run

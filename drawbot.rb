require 'discordrb'
require 'yaml'
require 'rest_client'

# at the beginning of your program in global scope
# $ symbol denotes a global variable

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

DEVCHANNEL = 180323434226647040
#To be moved to YAML soon. Probably on sunday.


bot = Discordrb::Commands::CommandBot.new token: $db['token'], application_id: 168123456789123456, prefix: '~'

#restart bot
bot.command(:restart, description: "restarts the bot") do |event|
  break unless event.channel.id == DEVCHANNEL
  event.channel.send_message("Restart issued.. :wrench:")
  bot.stop
  exit
end

bot.ready do |event|
  event.bot.send_message(DEVCHANNEL, "Drawbot online! Let's get some art done!")
  avatar = File.open('media/avatar.jpg','rb')
  event.bot.profile.avatar = avatar
  nil
end

#-----------COMMANDS COMMAND--------#
commands = [
  "=======",
  "~rules",
  "=======",
  "",
  "Drawing Commands",
  " ~draw",
  " ~drawlewd",
  " ~drawcombo",
  " ~drawfaglewd",
  " ~colour",
  " ~outfit",
  " ~pokemon",
  " ~fpose",
  "",
  "Fun Commands",
  " ~8ball",
  " ~zii(8ball clone)",
  " ~bad",
  " ~boop",
  " ~slap",
  " ~rub",
  " ~hump",
  " ~spray",
  " ~grope",
  " ~nellyheart",
  " ~snek",
  " ~lewd",
  " ~roll (default 6, add number after to make larger)",
  " ~pun",
  " ~told",
  " ~gimme",
  " ~pout",
  " ~poses",
  " ~texas",
  " ~salt",
  " ~orangyheart",
  " ~randomchar",
  "",
  "References (type ~refs then @them)",
  " AngryCoconut",
  " Bluebun",
  " ClearCandy",
  " Dako",
  " Echo",
  " GlooTheSlime",
  " Jim",
  " Luna",
  " Mothbro",
  " Mundy",
  " Murphy",
  " Nelsha",
  " Nim",
  " Nuclear",
  " Orangy",
  " Ossien",
  " Solitaire",
  " mpsketches"
]
#-------------VARIABLES-------------#

rules = ["Golden Rule Be excelent to each other
1 - This is not a hugbox, but that does not give you the right to be a dick
2 - This place is to help everyone improve their art skills. So please use constructive criticism
3 - If there is an active conversation going on please do not try to derail it
4 - Be mature. We are all adults, so don't go memeing it up too much
Rules will be added by majority interest or by obtuse necessity by the acting administration, and shall exclusively serve to maintain creative expressionism and the integrity of the community, or to prevent the abuse, harassment or bullying by or unto one of the participants"]

#___________________________________________
#___________________________________________
#___________________________________________

#-------------SILLY COMMANDS---------#

bot.command(:'8ball') do |event, *message|
  message = message.join(' ')
  fortune = EIGHTBALL.select { |e| !e['fortune'].empty? }.sample['fortune']
  event << "#{event.user.mention} `#{message}`: #{fortune}"
end

bot.command(:zii) do |event, *message|
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

bot.command(:boop) do |event, *message|
  message = message.join(' ')
  event << "#{event.user.display_name} #{BoopAction.sample} boops #{message}"
end

bot.command(:slap) do |event, *message|
  message = message.join(' ')
  event << "#{event.user.display_name} #{BoopAction.sample} slaps #{message}"
end

bot.command(:rub) do |event, *message|
  message = message.join(' ')
  event << "#{event.user.display_name} #{BoopAction.sample} rubs #{message}"
end

bot.command(:grope) do |event, *message|
  message = message.join(' ')
  event << "#{event.user.display_name} #{BoopAction.sample} gropes #{message}"
end

bot.command(:hug) do |event, *message|
  message = message.join(' ')
  event << "#{event.user.display_name} #{BoopAction.sample} hugs #{message}"
end

bot.command(:hump) do |event, *message|
  message = message.join(' ')
  event << "#{event.user.display_name} #{BoopAction.sample} humps #{message}"
end

bot.command(:doit) do |event|
  response = "https://puu.sh/pvFxQ/893adbe906.jpg"
  event << response
end

bot.command(:gimme) do |event|
  response = "http://puu.sh/pBgxi/d0b8de2e31.png"
  event << response
end

#TIMEOUT
bot.command(:bad) do |event, *message|
  break unless !event.user.roles.find { |x| x.name =="DBAdmin" }.nil?
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

bot.command(:nellyheart) do |event|
  response = "http://puu.sh/pc0pc/2b1b918f9d.png"
  event << "#{response}"
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

bot.command(:rules) do |event|
  event << "#{rules.join("\n")}"
end

bot.command(:commands) do |event|
  event << "#{commands.join("\n")}"
end


bot.command(:randomchar) do |event|
  event << "Your randomly generated pathfinder character is a"
  event << "#{Race.sample} #{PClass.sample}, #{Stats.sample}"
end

#COLOUR COMMAND
bot.command(:colour) do |event|
  event << "Your complementary colours are"
  event << "#{Compcolour.sample}"
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
  event << "You should draw something #{DrawComboTopic.sample} #{LewdDrawTopic.sample}"
end

bot.command(:drawcombo) do |event|
  event << "You should draw something #{DrawComboTopic.sample} #{NormalDrawTopic.sample}"
end

bot.command(:drawfaglewd) do |event|
  event << "You must draw #{Artists.sample} #{LewdDrawFagTopic.sample}"
end
#this is really cool, i'm glad it was added!
bot.command :pokemon do |event|
  pkmn = JSON.parse(RestClient.get("https://pokeapi.co/api/v2/pokemon/" + rand(1..721).to_s))
  url = JSON.parse(RestClient.get(pkmn['forms'][0]['url']))['sprites']['front_default']
  event << "Your pokemon to draw is: **#{pkmn['name'].split.map(&:capitalize).join(' ')}**"
  event << url
end

bot.command(:fpose) do |event|
  event << "The pose you get is #{Fpose.sample}"
end

bot.command(:poses) do |event|
  event << "roll 98\nhttps://puu.sh/oNXxK/474217250e.jpg\nroll 20\nhttps://puu.sh/oNxer/cb15424c85.jpg"
end

bot.command(:texas) do |event|
  event << "https://puu.sh/oQk1b/ddf195310c.png"
end

bot.command(:salt) do |event|
  event << "https://puu.sh/pwPPr/c4ea4b2e93.jpg"
end

bot.command(:orangyheart) do |event|
  event << "http://puu.sh/pCzpn/8f0f140aa1.jpg"
end



bot.command(:pout) do |event|
  event << "#{Pout.sample}"
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

bot.command :addref do |event, *url|
  break unless event.channel.id == DEVCHANNEL
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

  #flattery won't get you very far with KekBot
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

  #you can't give keks to yourself
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

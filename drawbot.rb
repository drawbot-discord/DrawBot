require 'discordrb'

require 'yaml'


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

bot = Discordrb::Commands::CommandBot.new token: $db['token'], application_id: 168123456789123456, prefix: '~'


#restart bot
bot.command(:restart, description: "restarts the bot") do |event|
  break unless event.channel.id == 180323434226647040

  bot.send_message(180323434226647040,"Restart issued.. :wrench:")
  bot.stop
  exit

end

bot.ready do |event|
  event << "Bot online! :heart:"
  avatar = File.open('media/avatar.jpg','rb')
  event.bot.profile.avatar = avatar
  nil
end
#require 'discordrb'

#bot = Discordrb::Bot.new token: '', application_id: 168123456789123456



#bot.command(:'') do |event|
#response = [
#].sample
#event << "#{event.user.mention} `#{message}`: #{response}"
#end



#bot.message(with_text: "~Hey Bot!") do |event|
 # event.respond "Hi, #{event.user.name}!"
#end





#-----------COMMANDS COMMAND--------#
commands = [
"=======",
"~rules",
"=======",
"",
"Drawing Commands",
"	~draw",
"	~drawlewd",
"	~drawcombo",
"	~drawfaglewd",
"	~colour",
"	~outfit",
"	~pokemon",
"",
"Fun Commands",
"	~8ball",
"	~bad",
"	~boop",
"	~slap",
"	~rub",
"	~spray",
"	~grope",
"	~nellyheart",
"	~snek",
"	~lewd",
"	~roll (default 6, add number after to make larger)",
"	~pun",
"",
"References (type ~refs before name)",
"	AngryCoconut",
"	Bluebun",
"	ClearCandy",
"	Dako",
"	Echo",
"	GlooTheSlime",
"	Jim",
"	Luna",
"	Mothbro",
"	Mundy",
"	Murphy",
"	Nelsha",
"	Nim",
"	Nuclear",
"	Orangy",
"	Ossien",
"	Solitaire",
"	mpsketches"
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
response = [
	"Nah",
	"Your Mother",
	"Pfft hahaha don't even ask.",
	"I don't feel like saying yes, so no",
	"Let me think about it..... no",
	"One sec. Let me ask my magic 8 ball...hold on...just a bit more...yes",
	"One sec. Let me ask my magic 8 ball...hold on...just a bit more...no",
	"Maybe if you yell louder",
	"Maybe if you shake harder you'll get a proper answer",
	"Does a bear shit in the woods?",
	"Do aliens stick shit up our poopers? Yes, yes they do.",
	"no, just stop",
	"It's not gonna happen, guy.",
	"Sure thing, friend",
	"No but I can make it a yes for $20",
	"Yes god dammit. Now quit shaking me!",
	"No, fuck you and your shitty dreams",
	"Stop oppressing me! No means No!",
	"Hell YEA",
	"Hell NO",
	"Fuck you, you figure it out",
	"Ha haha hahaha no",
	"Fuck yea",
	"Fuck no",
    "It is certain",
    "It is decidedly so",
    "Without a doubt",
    "Yes definitely",
    "You may rely on it",
    "As I see it, yes",
    "Most likely",
    "Outlook good",
    "Yes",
    "Signs point to yes",
    "Ask again later",
    "Don't count on it",
    "My reply is no",
    "Drawbot says no"].sample
	event << "#{event.user.mention} `#{message}`: #{response}"
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


#TIMEOUT
bot.command(:bad) do |event, *message|
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

bot.command(:rules) do |event|
event << "#{rules.join("\n")}"
end

bot.command(:commands) do |event|
event << "#{commands.join("\n")}"
end


#COLOUR COMMAND
bot.message(with_text: "~colour") do |event|
response = [
"Your complementarty colours are http://puu.sh/pqAwB/b5468b1654.png",
"Your complementarty colours are http://puu.sh/pqAx5/1c090a95b4.png",
"Your complementarty colours are http://puu.sh/pqAxT/cc4b5b2fc7.png",
"Your complementarty colours are http://puu.sh/pqAyG/7ab6b8f950.png",
"Your complementarty colours are http://puu.sh/pqAzl/4a32fab083.png",
"Your complementarty colours are http://puu.sh/pqAA8/f8106ac73e.png",
"Your complementarty colours are http://puu.sh/pqAB2/7d927ad8f6.png",
"Your complementarty colours are http://puu.sh/pqABX/b54a2abd04.png",
"Your complementarty colours are http://puu.sh/pqACN/9777db3774.png",
"Your complementarty colours are http://puu.sh/pqADI/e6b0ec3761.png",
"Your complementarty colours are http://puu.sh/pqAEA/783cfdd343.png",
"Your complementarty colours are http://puu.sh/pqAFj/48248a1609.png",
"Your complementarty colours are http://puu.sh/pqAFG/88a459c891.png",
"Your complementarty colours are http://puu.sh/pqAGE/c844df2fef.png",
"Your complementarty colours are http://puu.sh/pqAH6/b22e5c586f.png",
"Your complementarty colours are http://puu.sh/pqAHC/1cd551a06a.png",
"Your complementarty colours are http://puu.sh/pqAIz/ed77f33642.png",
"Your complementarty colours are http://puu.sh/pqAJo/0053f1fe57.png",
"Your complementarty colours are http://puu.sh/pqAK3/bbeaf93d37.png",
"Your complementarty colours are http://puu.sh/pqAKC/664004eb1f.png",
"Your complementarty colours are http://puu.sh/pqALq/c379d2693e.png",
"Your complementarty colours are http://puu.sh/pqAM3/07e445f7b1.png",
"Your complementarty colours are http://puu.sh/pqAMz/e6fecd98fa.png",
"Your complementarty colours are http://puu.sh/pqAN0/f5d1f3243b.png",
"Your complementarty colours are http://puu.sh/pqANz/71250f0876.png",
"Your complementarty colours are http://puu.sh/pqCp5/35616aae39.png",
"Your complementarty colours are http://puu.sh/pqCry/4149ac33ce.png",
"Your complementarty colours are http://puu.sh/pqCsf/da44188274.png",
"Your complementarty colours are http://puu.sh/pqCsV/427d4ce24c.png",
"Your complementarty colours are http://puu.sh/pqCty/1006208360.png",
"Your complementarty colours are http://puu.sh/pqCuf/9121b444b5.png",
"Your complementarty colours are http://puu.sh/pqCuQ/c81c283b27.png",
"Your complementarty colours are http://puu.sh/pqCwc/7bf6faac6a.png",
"Your complementarty colours are http://puu.sh/pqCwI/d1dadd50d1.png",
"Your complementarty colours are http://puu.sh/pqCxe/f56493c13a.png",
"Your complementarty colours are http://puu.sh/pqCyk/f6e4caf7ff.png",
"Your complementarty colours are http://puu.sh/pqCze/7d5d7f53da.png",
"Your complementarty colours are http://puu.sh/pqCA4/e3946d129d.png",
"Your complementarty colours are http://puu.sh/pqCAC/97ce61b43c.png",
"Your complementarty colours are http://puu.sh/pqCBn/b80a0d3bb8.png",
"Your complementarty colours are http://puu.sh/pqCCg/43e1354b35.png",
"Your complementarty colours are http://puu.sh/pqCCW/d433f6284d.png",
"Your complementarty colours are http://puu.sh/pqCDL/25f54ae1c9.png",
"Your complementarty colours are http://puu.sh/pqCEl/4e5da1116c.png",
"Your complementarty colours are http://puu.sh/pqCEW/b0e9ef7b99.png",
"Your complementarty colours are http://puu.sh/pqCFO/11adf02f6e.png",
"Your complementarty colours are http://puu.sh/pqCGs/4e7377b53b.png",
"Your complementarty colours are http://puu.sh/pqCHf/98acf8bddc.png"].sample

event << response

end




#LEWD COMMAND 
bot.command(:'lewd') do |event|
response = [
"https://i.imgur.com/I3apoUB.gif",
"https://i.imgur.com/um5vVcC.gif",
"https://i.imgur.com/pTb7vbZ.gif",
"https://i.imgur.com/cqiyR1L.gif",
"https://i.imgur.com/vZnMTFn.gif",
"https://i.imgur.com/Ftuig9v.gif",
"https://i.imgur.com/Gygj9sg.gif",
"https://i.imgur.com/pPVVu2b.gif",
"https://i.imgur.com/7QCizTa.gif",
"https://i.imgur.com/PS12w7X.gif",
"https://i.imgur.com/6fzs6jV.gif",
"https://i.imgur.com/eBjiGR9.gif",
"https://i.imgur.com/7KZ7hHy.gif",
"https://i.imgur.com/hJP68mL.gif",
"https://i.imgur.com/YXlOYiW.gif",
"https://i.imgur.com/fUBsH9X.jpg",
"https://i.imgur.com/MXeL1Jh.gif",
"https://i.imgur.com/pUBnlrE.gif",
"https://i.imgur.com/5xLBY1Y.gif",
"https://i.imgur.com/WurU1qy.jpg",
"https://i.imgur.com/UZV0T1p.gif",
"https://i.imgur.com/7ncmr6H.png",
"https://i.imgur.com/QQZmrJw.gif",
"https://media.giphy.com/media/Ek61AvsTykm6k/giphy.gif",
"https://i.imgur.com/3Etd0ik.gif",].sample

event <<  response
end


#---------DRAW COMMANDS-----------#


bot.command(:draw) do |event|
event << "You should draw #{DrawTopic.sample}"
end

bot.command(:drawlewd) do |event|
event << "You should draw something #{DrawComboTopic.sample} #{LewdDrawTopic.sample}"
end

bot.command(:drawcombo) do |event|
event << "You should draw something #{DrawComboTopic.sample}#{NormalDrawTopic.sample}"
end

bot.command(:drawfaglewd) do |event|
event << "You must draw #{Artists.sample} #{LewdDrawFagTopic.sample}"
end

bot.command(:pokemon) do |event|
event << "The pokemon you get to draw is #{Pokemon.sample}"
end

#-----------REFERENCES--------#

#uses the yaml file, add more artists there!

bot.command :refs do |event, *message|
    message = message.join(' ')
    user = Array.new

    #pull users refs from db
    $db['refs'].each do |key, value|
        if key.casecmp(message) == 0
            user = value
        end
    end

    #check if array is still empty
    #if it is, we didn't find a match
    if user.empty?
        event << "User not found.. :eyes:"
        return
    end

    #output each ref
    event << "#{message}'s refs:"
    user.each { |x| event << x }
    nil
end
#------------Eval-----------#
bot.command(:eval, help_available: false) do |event, *code|
  break unless event.user.id == 132893552102342656 # Replace number with your ID

  begin
    eval code.join(' ')
  rescue
    "An error occured 😞"
  end
end

bot.run
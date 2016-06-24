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

DEVCHANNEL = 180323434226647040

EIGHTBALL= [{ :fortune => "What? Yea, fine whatever. Yes", :zii => "http://puu.sh/pCwOM/a55cb94cea.jpg" },
            { :fortune => "Ugh not this time. No.", :zii => "http://puu.sh/pCwSu/a87c3f352e.jpg" },
            { :fortune => "would you hate me if I said no? because... no.", :zii => "" },
            { :fortune => "the truth is hard sometimes, and my answer is no", :zii => "http://puu.sh/pCwU7/7363e7b5ad.jpg" },
            { :fortune => "Yes. Do it. It'll be cool.", :zii => "http://puu.sh/pCwV1/6db9f62766.jpg" },
            { :fortune => "What is in it for me? Nothing? Ask later.", :zii => "http://puu.sh/pCwXm/e0def20ba2.jpg" },
            { :fortune => "uhhhhh, sure", :zii => "http://puu.sh/pCwZh/669d9212d8.jpg" },
            { :fortune => "Yea sure man I don't see why not.", :zii => "http://puu.sh/pCwZh/669d9212d8.jpg" },
            { :fortune => "Yes as long as you give me head pats.", :zii => "http://puu.sh/pCwZu/772d8e3e09.jpg" },
            { :fortune => "Mmmm no.", :zii => "http://puu.sh/pCx1M/672739a131.jpg" },
            { :fortune => "Yea if you call me a cutie :heart:", :zii => "http://puu.sh/pCx4v/57577b2411.jpg" },
            { :fortune => "let me take a picture of you face first. Ok now, yea.", :zii => "http://puu.sh/pCxbC/8049f3232f.jpg" },
            { :fortune => "Don't talk to me right now, LEave me alone. Ask later", :zii => "http://puu.sh/pCxcy/68da5bc7b9.jpg" },
            { :fortune => "Go away, ask later. Jerk", :zii => "http://puu.sh/pCxdc/28e7b19d9d.jpg" },
            { :fortune => "Does that seem like a good idea? No. Because it's not.", :zii => "http://puu.sh/pCxe4/fbde5b31bf.jpg" },
            { :fortune => "Don't worry I don't blame you. You can ask later", :zii => "http://puu.sh/pCxfZ/7669209698.jpg" },
            { :fortune => "I'm sorry ask me some other time.", :zii => "http://puu.sh/pCxgA/d8f919ec8e.jpg" },
            { :fortune => "Fine yes!", :zii => "http://puu.sh/pCxhm/1637cc0f7d.jpg" },
            { :fortune => "Sure whatever.", :zii => "http://puu.sh/pCxid/1f8c059fa1.jpg" },
            { :fortune => "Yea, but ony cause I care about you.", :zii => "http://puu.sh/pCxky/784115712b.jpg" },
            { :fortune => "I'm going for a drive, ask me in a bit.", :zii => "http://puu.sh/pCxqR/7a8158fc89.jpg" },
            { :fortune => "yes...?", :zii => "http://puu.sh/pCxt4/a3a64a85a8.jpg" },
            { :fortune => "Heh.. heh.. Ask later?", :zii => "http://puu.sh/pCxwo/ff11e43c1f.jpg" },
            { :fortune => "Yyyyeeaaa....", :zii => "http://puu.sh/pCxx8/783e6b98c0.jpg" },
            { :fortune => "Yes sure let's get on with it", :zii => "http://puu.sh/pCxyV/c2c2da4a01.jpg" },
            { :fortune => "FINE YES JUST STOP SHAKING MY HEAD", :zii => "http://puu.sh/pCxF3/a2c110de3c.jpg" },
            { :fortune => "What? No. Don't ever ask again", :zii => "http://puu.sh/pCxIp/a22edff12b.jpg" },
            { :fortune => "Uhhhhhh nnnoooooo", :zii => "http://puu.sh/pCxJr/1d917a0ecf.jpg" },
            { :fortune => "Is... is that the thing you want? no man. god.", :zii => "http://puu.sh/pCxKR/7bbd6d36e9.jpg" },
            { :fortune => "No and no to your next question", :zii => "http://puu.sh/pCxLU/dffe1dd72a.jpg" },
            { :fortune => "A-ask again l-later...", :zii => "http://puu.sh/pCxMd/b47a317e88.jpg" },
            { :fortune => "That's a hard question.... ask me again some other time please?", :zii => "http://puu.sh/pCxMx/7e4d32fc38.jpg" },
            { :fortune => "Yea I don't see why not", :zii => "http://puu.sh/pCutG/b3085a9fb2.jpg" },
            { :fortune => "Pffft Haha, yea sure why not", :zii => "http://puu.sh/pCuvw/64b387388a.jpg" },
            { :fortune => "A-ask again later", :zii => "http://puu.sh/pCuwA/e60052bb42.jpg" },
            { :fortune => "give me a sec... ask me some other time...", :zii => "http://puu.sh/pCuxf/bb2633b2ad.jpg" },
            { :fortune => "Yes.... Yes...", :zii => "http://puu.sh/pCuys/40a51a64cb.jpg" },
            { :fortune => "mmmmm..... maybe", :zii => "http://puu.sh/pCuzt/f415ddcf09.jpg" },
            { :fortune => "N-no...", :zii => "http://puu.sh/pCuAR/72b993d9dd.jpg" },
            { :fortune => "sure thing big boy", :zii => "http://puu.sh/pCuBY/08697be7b3.jpg" },
            { :fortune => "certainly!", :zii => "http://puu.sh/pCuCP/473f07c1a4.jpg" },
            { :fortune => "Yes I'm feeling it", :zii => "http://puu.sh/pCuDC/b9dee75ad9.jpg" },
            { :fortune => "yes", :zii => "http://puu.sh/pCuFV/4b85f5a1a5.jpg" },
            { :fortune => "oh boy! Yes!", :zii => "http://puu.sh/pCuH2/c5cb50dd2b.jpg" },
            { :fortune => "dude no, let it go", :zii => "http://puu.sh/pCuIN/e25702470e.jpg" },
            { :fortune => "what do you think?", :zii => "http://puu.sh/pCuJv/388cdd25eb.jpg" },
            { :fortune => "I'm not sure...", :zii => "http://puu.sh/pCuKl/da6528c513.jpg" },
            { :fortune => "I don't wanna answer that", :zii => "http://puu.sh/pCuKY/643e2dff72.jpg" },
            { :fortune => "yes, but you will regret it", :zii => "http://puu.sh/pCuMW/9767fe964d.jpg" },
            { :fortune => "c-come back later", :zii => "http://puu.sh/pCuNZ/21ed1d828c.jpg" },
            { :fortune => "ve me time to think about it", :zii => "http://puu.sh/pCuPt/7ce105b079.jpg" },
            { :fortune => "no you fucker!", :zii => "http://puu.sh/pCuQL/789a74f811.jpg" },
            { :fortune => "yea sure, what ever", :zii => "http://puu.sh/pCuRi/c2af6ab667.jpg" },
            { :fortune => "no not this time...", :zii => "http://puu.sh/pCuS2/72b6a67f74.jpg" },
            { :fortune => "hell yea man", :zii => "http://puu.sh/pCuU6/c34922448f.jpg" },
            { :fortune => "Nah", :zii => "http://puu.sh/pBohd/86210da8e5.png" },
            { :fortune => "Your Mother", :zii => "http://puu.sh/pBoq8/a52417e26f.jpg" },
            { :fortune => "Pfft hahaha don't even ask.", :zii => "http://puu.sh/pBor6/6a4ba444fc.jpg" },
            { :fortune => "I don't feel like saying yes, so no", :zii => "http://puu.sh/pBov7/31d4796a73.png" },
            { :fortune => "Let me think about it..... no", :zii => "http://puu.sh/pBosq/5f1d0e3479.png" },
            { :fortune => "One sec. Let me ask my magic 8 ball...hold on...just a bit more...yes", :zii => "http://puu.sh/pBox4/5811840c5c.png" },
            { :fortune => "One sec. Let me ask my magic 8 ball...hold on...just a bit more...no", :zii => "http://puu.sh/pBow6/567875b3ac.jpg" },
            { :fortune => "Maybe if you yell louder", :zii => "http://puu.sh/pBoxH/c150a055ed.png" },
            { :fortune => "Maybe if you shake harder you'll get a proper answer", :zii => "http://puu.sh/pBoy8/dafb191e20.png" },
            { :fortune => "Does a bear shit in the woods?", :zii => "http://puu.sh/pBoD4/e399c9a5ea.jpg" },
            { :fortune => "Do aliens stick shit up our poopers? Yes, yes they do.", :zii => "http://puu.sh/pBoDN/309a8725ef.png" },
            { :fortune => "no, just stop", :zii => "http://puu.sh/pBoEt/492ee5ecb5.jpg" },
            { :fortune => "It's not gonna happen, guy.", :zii => "http://puu.sh/pBoFn/b3327e5f17.jpg" },
            { :fortune => "Sure thing, friend", :zii => "http://puu.sh/pBoG0/9fea6ced19.jpg" },
            { :fortune => "No but I can make it a yes for $20", :zii => "http://puu.sh/pBoHY/9c561c47b3.png" },
            { :fortune => "Yes god dammit. Now quit shaking me!", :zii => "http://puu.sh/pBoID/4495d77f3c.png" },
            { :fortune => "No, fuck you and your shitty dreams", :zii => "http://puu.sh/pBoJP/0ec1b5a19a.png" },
            { :fortune => "Stop oppressing me! No means No!", :zii => "http://puu.sh/pBoKd/46a632c992.png" },
            { :fortune => "Hell YEA", :zii => "http://puu.sh/pBoLm/f9e3a3b416.jpg" },
            { :fortune => "Hell NO", :zii => "http://puu.sh/pBoME/7c410e64a9.jpg" },
            { :fortune => "Fuck you, you figure it out", :zii => "http://puu.sh/pBoNB/dfd904b8fe.jpg" },
            { :fortune => "Ha haha hahaha no", :zii => "http://puu.sh/pBoO4/a1a4a04145.jpg" },
            { :fortune => "Fuck yea", :zii => "http://puu.sh/pBoOP/66e7448ab7.jpg" },
            { :fortune => "Fuck no", :zii => "http://puu.sh/pBoPP/eabf6e1ae2.png" },
            { :fortune => "It is certain", :zii => "http://puu.sh/pBoUg/8b16d31453.png" },
            { :fortune => "It is decidedly so", :zii => "http://puu.sh/pBoVa/30164ceae0.png" },
            { :fortune => "Without a doubt", :zii => "http://puu.sh/pBoQo/76a7125b54.png" },
            { :fortune => "Yes definitely", :zii => "http://puu.sh/pBoTF/56fe2f5b8d.png" },
            { :fortune => "You may rely on it", :zii => "http://puu.sh/pBoTj/7c2664df15.png" },
            { :fortune => "As I see it, yes", :zii => "http://puu.sh/pBoWf/e73c08fcac.png" },
            { :fortune => "Most likely", :zii => "http://puu.sh/pBoSw/8963c65d89.png" },
            { :fortune => "Doesn't look good...", :zii => "http://puu.sh/pBoRT/ab49e451c9.png" },
            { :fortune => "Yes", :zii => "http://puu.sh/pBoWx/ca8bf43307.jpg" },
            { :fortune => "Signs point to yes", :zii => "http://puu.sh/pBoYk/87127da2ad.png" },
            { :fortune => "Ask again later", :zii => "http://puu.sh/pBoYJ/c7fe27ca63.jpg" },
            { :fortune => "Don't count on it", :zii => "http://puu.sh/pBoZR/a4cddea3f4.png" },
            { :fortune => "My reply is no", :zii => "http://puu.sh/pBp0c/8648ce0a70.png" },
            { :fortune => "Drawbot says no", :zii => "http://puu.sh/pBp0L/0c77ff36c7.png" },
            { :zii => "http://puu.sh/pCwQc/b10381298b.jpg"},
            { :zii => "http://puu.sh/pCxrg/490bb762aa.jpg"},
            { :zii => "http://puu.sh/pCxGO/3a27832a82.jpg"},
            { :zii => "http://puu.sh/pCuIb/54c95d8a75.jpg"},
            { :zii => "http://puu.sh/pCuM3/e2508bc376.jpg"},
            { :zii => "http://puu.sh/pCuTm/8adfba1e8b.jpg"}]

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
  fortune = EIGHTBALL.select { |e| e[:fortune] }.sample[:fortune]
  event << "#{event.user.mention} `#{message}`: #{fortune}"
end

bot.command(:zii) do |event, *message|
  message = message.join(' ')

  index = rand 0..EIGHTBALL.length-1
  fortune = EIGHTBALL[index][:fortune]
  zii = EIGHTBALL[index][:zii]

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

#COLOUR COMMAND
bot.message(with_text: "~colour") do |event|
  response = [
    "Your complementarty colours are\nhttp://puu.sh/pqAwB/b5468b1654.png",
    "Your complementarty colours are\nhttp://puu.sh/pqAx5/1c090a95b4.png",
    "Your complementarty colours are\nhttp://puu.sh/pqAxT/cc4b5b2fc7.png",
    "Your complementarty colours are\nhttp://puu.sh/pqAyG/7ab6b8f950.png",
    "Your complementarty colours are\nhttp://puu.sh/pqAzl/4a32fab083.png",
    "Your complementarty colours are\nhttp://puu.sh/pqAA8/f8106ac73e.png",
    "Your complementarty colours are\nhttp://puu.sh/pqAB2/7d927ad8f6.png",
    "Your complementarty colours are\nhttp://puu.sh/pqABX/b54a2abd04.png",
    "Your complementarty colours are\nhttp://puu.sh/pqACN/9777db3774.png",
    "Your complementarty colours are\nhttp://puu.sh/pqADI/e6b0ec3761.png",
    "Your complementarty colours are\nhttp://puu.sh/pqAEA/783cfdd343.png",
    "Your complementarty colours are\nhttp://puu.sh/pqAFj/48248a1609.png",
    "Your complementarty colours are\nhttp://puu.sh/pqAFG/88a459c891.png",
    "Your complementarty colours are\nhttp://puu.sh/pqAGE/c844df2fef.png",
    "Your complementarty colours are\nhttp://puu.sh/pqAH6/b22e5c586f.png",
    "Your complementarty colours are\nhttp://puu.sh/pqAHC/1cd551a06a.png",
    "Your complementarty colours are\nhttp://puu.sh/pqAIz/ed77f33642.png",
    "Your complementarty colours are\nhttp://puu.sh/pqAJo/0053f1fe57.png",
    "Your complementarty colours are\nhttp://puu.sh/pqAK3/bbeaf93d37.png",
    "Your complementarty colours are\nhttp://puu.sh/pqAKC/664004eb1f.png",
    "Your complementarty colours are\nhttp://puu.sh/pqALq/c379d2693e.png",
    "Your complementarty colours are\nhttp://puu.sh/pqAM3/07e445f7b1.png",
    "Your complementarty colours are\nhttp://puu.sh/pqAMz/e6fecd98fa.png",
    "Your complementarty colours are\nhttp://puu.sh/pqAN0/f5d1f3243b.png",
    "Your complementarty colours are\nhttp://puu.sh/pqANz/71250f0876.png",
    "Your complementarty colours are\nhttp://puu.sh/pqCp5/35616aae39.png",
    "Your complementarty colours are\nhttp://puu.sh/pqCry/4149ac33ce.png",
    "Your complementarty colours are\nhttp://puu.sh/pqCsf/da44188274.png",
    "Your complementarty colours are\nhttp://puu.sh/pqCsV/427d4ce24c.png",
    "Your complementarty colours are\nhttp://puu.sh/pqCty/1006208360.png",
    "Your complementarty colours are\nhttp://puu.sh/pqCuf/9121b444b5.png",
    "Your complementarty colours are\nhttp://puu.sh/pqCuQ/c81c283b27.png",
    "Your complementarty colours are\nhttp://puu.sh/pqCwc/7bf6faac6a.png",
    "Your complementarty colours are\nhttp://puu.sh/pqCwI/d1dadd50d1.png",
    "Your complementarty colours are\nhttp://puu.sh/pqCxe/f56493c13a.png",
    "Your complementarty colours are\nhttp://puu.sh/pqCyk/f6e4caf7ff.png",
    "Your complementarty colours are\nhttp://puu.sh/pqCze/7d5d7f53da.png",
    "Your complementarty colours are\nhttp://puu.sh/pqCA4/e3946d129d.png",
    "Your complementarty colours are\nhttp://puu.sh/pqCAC/97ce61b43c.png",
    "Your complementarty colours are\nhttp://puu.sh/pqCBn/b80a0d3bb8.png",
    "Your complementarty colours are\nhttp://puu.sh/pqCCg/43e1354b35.png",
    "Your complementarty colours are\nhttp://puu.sh/pqCCW/d433f6284d.png",
    "Your complementarty colours are\nhttp://puu.sh/pqCDL/25f54ae1c9.png",
    "Your complementarty colours are\nhttp://puu.sh/pqCEl/4e5da1116c.png",
    "Your complementarty colours are\nhttp://puu.sh/pqCEW/b0e9ef7b99.png",
    "Your complementarty colours are\nhttp://puu.sh/pqCFO/11adf02f6e.png",
    "Your complementarty colours are\nhttp://puu.sh/pqCGs/4e7377b53b.png",
  "Your complementarty colours are\nhttp://puu.sh/pqCHf/98acf8bddc.png"].sample

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

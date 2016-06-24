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
Told = $db['told']
Pout = $db['pout']
Rekt = $db['rekt']

bot = Discordrb::Commands::CommandBot.new token: $db['token'], application_id: 168123456789123456, prefix: '~'

#restart bot
bot.command(:restart, description: "restarts the bot") do |event|
  break unless event.channel.id == 180323434226647040

  bot.send_message(180323434226647040,"Restart issued.. :wrench:")
  bot.stop
  exit

end

bot.ready do |event|
  event.bot.send_message(180323434226647040, "Drawbot online! Let's get some art done!")
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
  " ~zii(8ball clone)"
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
  response = ["What? Yea, fine whatever. Yes",
              "Ugh not this time. No.",
              "would you hate me if I said no? because... no.",
              "the truth is hard sometimes, and my answer is no",
              "Yes. Do it. It'll be cool.",
              "What is in it for me? Nothing? Ask later.",
              "uhhhhh, sure",
              "Yea sure man I don't see why not.",
              "Yes as long as you give me head pats.",
              "Mmmm no.",
              "Yea if you call me a cutie :heart:",
              "let me take a picture of you face first. Ok now, yea.",
              "Don't talk to me right now, LEave me alone. Ask later",
              "Go away, ask later. Jerk",
              "Does that seem like a good idea? No. Because it's not.",
              "Don't worry I don't blame you. You can ask later",
              "I'm sorry ask me some other time.",
              "Fine yes!",
              "Sure whatever.",
              "Yea, but ony cause I care about you.",
              "I'm going for a drive, s ask me in a bit.",
              "yes...?",
              "Heh.. heh.. Ask later?",
              "Yyyyeeaaa....",
              "Yes sure let's get on with it",
              "FINE YES JUST STOP SHAKING MY HEAD",
              "What? No. Don't ever ask again",
              "Uhhhhhh nnnoooooo",
              "Is... is that the thing you want? no man. god.",
              "No and no to your next question",
              "A-ask again l-later...",
              "That's a hard question.... ask me again some other time please?",
              "Yea I don't see why not",
              "Pffft Haha, yea sure why not",
              "A-ask again later",
              "give me a sec... ask me some other time...",
              "Yes.... Yes...",
              "mmmmm..... maybe",
              "N-no...",
              "sure thing big boy",
              "certainly!",
              "Yes I'm feeling it",
              "yes",
              "oh boy! Yes!",
              "dude no, let it go",
              "what do you think?",
              "I'm not sure...",
              "I don't wanna answer that",
              "yes, but you will regret it",
              "c-come back later",
              "ve me time to think about it",
              "no you fucker!",
              "yea sure, what ever",
              "no not this time...",
              "hell yea man",
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
              "Doesn't look good...",
              "Yes",
              "Signs point to yes",
              "Ask again later",
              "Don't count on it",
              "My reply is no",
              "Drawbot says no"].sample
  event << "#{event.user.mention} `#{message}`: #{response}"
end



bot.command(:'zii') do |event, *message|
  message = message.join(' ')
  response = ["http://puu.sh/pCwOM/a55cb94cea.jpg\nWhat? Yea, fine whatever. Yes",
              "http://puu.sh/pCwQc/b10381298b.jpg",
              "http://puu.sh/pCwSu/a87c3f352e.jpg\nUgh not this time. No.",
              "http://puu.sh/pCwTj/fbcbaa61b6.jpg\nwould you hate me if I said no? because... no.",
              "http://puu.sh/pCwU7/7363e7b5ad.jpg\nthe truth is hard sometimes, and my answer is no",
              "http://puu.sh/pCwV1/6db9f62766.jpg\nYes. Do it. It'll be cool.",
              "http://puu.sh/pCwXm/e0def20ba2.jpg\nWhat is in it for me? Nothing? Ask later.",
              "http://puu.sh/pCwZh/669d9212d8.jpg\nuhhhhh, sure",
              "http://puu.sh/pCwZh/669d9212d8.jpg\nYea sure man I don't see why not.",
              "http://puu.sh/pCwZu/772d8e3e09.jpg\nYes as long as you give me head pats.",
              "http://puu.sh/pCx1M/672739a131.jpg\nMmmm no.",
              "http://puu.sh/pCx4v/57577b2411.jpg\nYea if you call me a cutie :heart:",
              "http://puu.sh/pCxbC/8049f3232f.jpg\nlet me take a picture of you face first. Ok now, yea.",
              "http://puu.sh/pCxcy/68da5bc7b9.jpg\nDon't talk to me right now, LEave me alone. Ask later",
              "http://puu.sh/pCxdc/28e7b19d9d.jpg\nGo away, ask later. Jerk",
              "http://puu.sh/pCxe4/fbde5b31bf.jpg\nDoes that seem like a good idea? No. Because it's not.",
              "http://puu.sh/pCxfZ/7669209698.jpg\nDon't worry I don't blame you. You can ask later",
              "http://puu.sh/pCxgA/d8f919ec8e.jpg\nI'm sorry ask me some other time.",
              "http://puu.sh/pCxhm/1637cc0f7d.jpg\nFine yes!",
              "http://puu.sh/pCxid/1f8c059fa1.jpg\nSure whatever.",
              "http://puu.sh/pCxky/784115712b.jpg\nYea, but ony cause I care about you.",
              "http://puu.sh/pCxqR/7a8158fc89.jpg\nI'm going for a drive, s ask me in a bit.",
              "http://puu.sh/pCxrg/490bb762aa.jpg",
              "http://puu.sh/pCxt4/a3a64a85a8.jpg\nyes...?",
              "http://puu.sh/pCxwo/ff11e43c1f.jpg\nHeh.. heh.. Ask later?",
              "http://puu.sh/pCxx8/783e6b98c0.jpg\nYyyyeeaaa....",
              "http://puu.sh/pCxyV/c2c2da4a01.jpg\nYes sure let's get on with it",
              "http://puu.sh/pCxF3/a2c110de3c.jpg\nFINE YES JUST STOP SHAKING MY HEAD",
              "http://puu.sh/pCxGO/3a27832a82.jpg",
              "http://puu.sh/pCxIp/a22edff12b.jpg\nWhat? No. Don't ever ask again",
              "http://puu.sh/pCxJr/1d917a0ecf.jpg\nUhhhhhh nnnoooooo",
              "http://puu.sh/pCxKR/7bbd6d36e9.jpg\nIs... is that the thing you want? no man. god.",
              "http://puu.sh/pCxLU/dffe1dd72a.jpg\nNo and no to your next question",
              "http://puu.sh/pCxMd/b47a317e88.jpg\nA-ask again l-later...",
              "http://puu.sh/pCxMx/7e4d32fc38.jpg\nThat's a hard question.... ask me again some other time please?",
              "http://puu.sh/pCutG/b3085a9fb2.jpg\nYea I don't see why not\n",
              "http://puu.sh/pCuvw/64b387388a.jpg\nPffft Haha, yea sure why not\n",
              "http://puu.sh/pCuwA/e60052bb42.jpg\nA-ask again later",
              "http://puu.sh/pCuxf/bb2633b2ad.jpg\ngive me a sec... ask me some other time...",
              "http://puu.sh/pCuys/40a51a64cb.jpg\nYes.... Yes...",
              "http://puu.sh/pCuzt/f415ddcf09.jpg\nmmmmm..... maybe",
              "http://puu.sh/pCuAR/72b993d9dd.jpg\nN-no...",
              "http://puu.sh/pCuBY/08697be7b3.jpg\nsure thing big boy",
              "http://puu.sh/pCuCP/473f07c1a4.jpg\ncertainly!",
              "http://puu.sh/pCuDC/b9dee75ad9.jpg\nYes I'm feeling it",
              "http://puu.sh/pCuFV/4b85f5a1a5.jpg\nyes",
              "http://puu.sh/pCuH2/c5cb50dd2b.jpg\noh boy! Yes!",
              "http://puu.sh/pCuIb/54c95d8a75.jpg",
              "http://puu.sh/pCuIN/e25702470e.jpg\ndude no, let it go",
              "http://puu.sh/pCuJv/388cdd25eb.jpg\nwhat do you think?",
              "http://puu.sh/pCuKl/da6528c513.jpg\nI'm not sure...",
              "http://puu.sh/pCuKY/643e2dff72.jpg\nI don't wanna answer that",
              "http://puu.sh/pCuM3/e2508bc376.jpg",
              "http://puu.sh/pCuMW/9767fe964d.jpg\nyes, but you will regret it",
              "http://puu.sh/pCuNZ/21ed1d828c.jpg\nc-come back later",
              "http://puu.sh/pCuPt/7ce105b079.jpggive me time to think about it",
              "http://puu.sh/pCuQL/789a74f811.jpg\nno you fucker!",
              "http://puu.sh/pCuRi/c2af6ab667.jpg\nyea sure, what ever",
              "http://puu.sh/pCuS2/72b6a67f74.jpg\nno not this time...",
              "http://puu.sh/pCuTm/8adfba1e8b.jpg",
              "http://puu.sh/pCuU6/c34922448f.jpg\nhell yea man",
              "http://puu.sh/pBohd/86210da8e5.png\nNah",
              "http://puu.sh/pBoq8/a52417e26f.jpg\nYour Mother",
              "http://puu.sh/pBor6/6a4ba444fc.jpg\nPfft hahaha don't even ask.",
              "http://puu.sh/pBov7/31d4796a73.png\nI don't feel like saying yes, so no",
              "http://puu.sh/pBosq/5f1d0e3479.png\nLet me think about it..... no\n",
              "http://puu.sh/pBox4/5811840c5c.png\nOne sec. Let me ask my magic 8 ball...hold on...just a bit more...yes\n",
              "http://puu.sh/pBow6/567875b3ac.jpg\nOne sec. Let me ask my magic 8 ball...hold on...just a bit more...no",
              "http://puu.sh/pBoxH/c150a055ed.png\nMaybe if you yell louder",
              "http://puu.sh/pBoy8/dafb191e20.png\nMaybe if you shake harder you'll get a proper answer",
              "http://puu.sh/pBoD4/e399c9a5ea.jpg\nDoes a bear shit in the woods?",
              "http://puu.sh/pBoDN/309a8725ef.png\nDo aliens stick shit up our poopers? Yes, yes they do.",
              "http://puu.sh/pBoEt/492ee5ecb5.jpg\nno, just stop",
              "http://puu.sh/pBoFn/b3327e5f17.jpg\nIt's not gonna happen, guy.",
              "http://puu.sh/pBoG0/9fea6ced19.jpg\nSure thing, friend",
              "http://puu.sh/pBoHY/9c561c47b3.png\nNo but I can make it a yes for $20",
              "http://puu.sh/pBoID/4495d77f3c.png\nYes god dammit. Now quit shaking me!",
              "http://puu.sh/pBoJP/0ec1b5a19a.png\nNo, fuck you and your shitty dreams",
              "http://puu.sh/pBoKd/46a632c992.png\nStop oppressing me! No means No!",
              "http://puu.sh/pBoLm/f9e3a3b416.jpg\nHell YEA",
              "http://puu.sh/pBoME/7c410e64a9.jpg\nHell NO",
              "http://puu.sh/pBoNB/dfd904b8fe.jpg\nFuck you, you figure it out",
              "http://puu.sh/pBoO4/a1a4a04145.jpg\nHa haha hahaha no",
              "http://puu.sh/pBoOP/66e7448ab7.jpg\nFuck yea",
              "http://puu.sh/pBoPP/eabf6e1ae2.png\nFuck no",
              "http://puu.sh/pBoUg/8b16d31453.png\nIt is certain",
              "http://puu.sh/pBoVa/30164ceae0.png\nIt is decidedly so",
              "http://puu.sh/pBoQo/76a7125b54.png\nWithout a doubt",
              "http://puu.sh/pBoTF/56fe2f5b8d.png\nYes definitely",
              "http://puu.sh/pBoTj/7c2664df15.png\nYou may rely on it",
              "http://puu.sh/pBoWf/e73c08fcac.png\nAs I see it, yes",
              "http://puu.sh/pBoSw/8963c65d89.png\nMost likely",
              "http://puu.sh/pBoRT/ab49e451c9.png\nDoesn't look good...",
              "http://puu.sh/pBoWx/ca8bf43307.jpg\nYes",
              "http://puu.sh/pBoYk/87127da2ad.png\nSigns point to yes",
              "http://puu.sh/pBoYJ/c7fe27ca63.jpg\nAsk again later",
              "http://puu.sh/pBoZR/a4cddea3f4.png\nDon't count on it",
              "http://puu.sh/pBp0c/8648ce0a70.png\nMy reply is no",
              "http://puu.sh/pBp0L/0c77ff36c7.png\nDrawbot says no"].sample
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
  event << $db['told'].join("\n")
end
bot.command(:rekt) do |event|
  event << $db['rekt'].join("\n")
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
  event << "You should draw something #{DrawComboTopic.sample} #{NormalDrawTopic.sample}"
end

bot.command(:drawfaglewd) do |event|
  event << "You must draw #{Artists.sample} #{LewdDrawFagTopic.sample}"
end

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
  break unless event.channel.id == 180323434226647040
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

bot.run
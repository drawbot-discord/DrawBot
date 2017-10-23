module Bot
  module DiscordCommands
    # Document your command
    # in some YARD comments here!
    module MyCommand
      extend Discordrb::Commands::CommandContainer
      $db = YAML.load(File.read('data/boop.yaml'))
      BoopAction = $db['BoopAction']

      command(:wave) do |event, *message|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
        next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
         message = message.join(' ')
         event << "#{event.user.display_name} waves #{message}"
         event.message.delete
      end

      command(:boop) do |event, *message|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
        next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
         message = message.join(' ')
         event << "#{event.user.display_name} #{BoopAction.sample} boops #{message}"
         event.message.delete
      end

      command(:slap) do |event, *message|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
        next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
         message = message.join(' ')
         event << "#{event.user.display_name} #{BoopAction.sample} slaps #{message}"
         event.message.delete
      end

      command(:spank) do |event, *message|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
        next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
         message = message.join(' ')
         event << "#{event.user.display_name} #{BoopAction.sample} spanks #{message}"
         event.message.delete
      end

      command(:rub) do |event, *message|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
        next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
         message = message.join(' ')
         event << "#{event.user.display_name} #{BoopAction.sample} rubs #{message}"
         event.message.delete
      end

      command(:grope) do |event, *message|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
        next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
         message = message.join(' ')
         event << "#{event.user.display_name} #{BoopAction.sample} gropes #{message}"
         event.message.delete
      end

      command(:hug) do |event, *message|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
        next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
         message = message.join(' ')
         event << "#{event.user.display_name} #{BoopAction.sample} hugs #{message}"
         event.message.delete
      end

      command(:hump) do |event, *message|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
        next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
         message = message.join(' ')
         event << "#{event.user.display_name} #{BoopAction.sample} humps #{message}"
         event.message.delete
      end

      command(:bite) do |event, *message|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
        next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
         message = message.join(' ')
         event << "#{event.user.display_name} #{BoopAction.sample} bites #{message}"
         event.message.delete
      end

      command(:smack) do |event, *message|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
        next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
         message = message.join(' ')
         event << "#{event.user.display_name} #{BoopAction.sample} smacks #{message}"
         event.message.delete
      end

      command(:punch) do |event, *message|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
        next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
         message = message.join(' ')
         event << "#{event.user.display_name} #{BoopAction.sample} punches #{message}"
         event.message.delete
      end

      command(:noogie) do |event, *message|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
        next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
         message = message.join(' ')
         event << "#{event.user.display_name} gives #{message} a noogie"
         event.message.delete
      end

      command(:smell) do |event, *message|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
        next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
         message = message.join(' ')
         event << "#{event.user.display_name} smells #{message}"
         event.message.delete
      end

      command(:lick) do |event, *message|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
        next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
         message = message.join(' ')
         event << "#{event.user.display_name} #{BoopAction.sample} licks #{message}"
         event.message.delete
      end

      command(:kick) do |event, *message|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
        next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
         message = message.join(' ')
         event << "#{event.user.display_name} #{BoopAction.sample} kicks #{message}"
         event.message.delete
      end

      command(:chop) do |event, *message|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
        next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
         message = message.join(' ')
         event << "#{event.user.display_name} #{BoopAction.sample} karate chops #{message}"
         event.message.delete
      end

      command(:squeeze) do |event, *message|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
        next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
         message = message.join(' ')
         event << "#{event.user.display_name} #{BoopAction.sample} squeezes #{message}"
         event.message.delete
      end

      command(:arrest) do |event, *message|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
        next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
         message = message.join(' ')
         event << "#{event.user.display_name} #{BoopAction.sample} arrests #{message}"
         event.message.delete
      end

      command(:sharpie) do |event, *message|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
        next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
         message = message.join(' ')
         event << "#{event.user.display_name} draws all over #{message} with a sharpie"
         event.message.delete
      end

      command(:dance) do |event, *message|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
        next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
         message = message.join(' ')
         event << "#{event.user.display_name} #{BoopAction.sample} dances with #{message}"
         event.message.delete
      end

      command(:pat) do |event, *message|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
        next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
         message = message.join(' ')
         event << "#{event.user.display_name} #{BoopAction.sample} pats #{message}"
         event.message.delete
      end

      command(:pet) do |event, *message|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
        next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
         message = message.join(' ')
         event << "#{event.user.display_name} #{BoopAction.sample} pets #{message}"
         event.message.delete
      end

      command(:sit) do |event, *message|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
        next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
         message = message.join(' ')
         event << "#{event.user.display_name} #{BoopAction.sample} sits on #{message}"
         event.message.delete
      end

      command(:tease) do |event, *message|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
        next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
         message = message.join(' ')
         event << "#{event.user.display_name} #{BoopAction.sample} teases #{message}"
         event.message.delete
      end

      command(:whip) do |event, *message|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
        next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
         message = message.join(' ')
         event << "#{event.user.display_name} #{BoopAction.sample} whips #{message}"
         event.message.delete
      end

      command(:murder) do |event, *message|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
        next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
         message = message.join(' ')
         event << "#{event.user.display_name} #{BoopAction.sample} murders #{message}"
         event.message.delete
      end

      command(:wink) do |event, *message|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
        next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
         message = message.join(' ')
         event << "#{event.user.display_name} #{BoopAction.sample} winks at #{message}"
         event.message.delete
      end

      command(:kiss) do |event, *message|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
        next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
         message = message.join(' ')
         event << "#{event.user.display_name} gives #{message} a kiss :kiss:"
         event.message.delete
      end

      command(:lean) do |event, *message|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
        next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
         message = message.join(' ')
         event << "#{event.user.display_name} #{BoopAction.sample} leans on #{message}"
         event.message.delete
      end

      command(:squish) do |event, *message|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
        next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
         message = message.join(' ')
         event << "#{event.user.display_name} squishes #{message} Quick, grab the broom!"
         event.message.delete
      end

      command(:pokeball) do |event, *message|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["playful", "unlocksfw"]
        next event.respond "I need the `playful` or `unlocksfw` role for that, silly" if check.empty?
         message = message.join(' ')
         catch = ['caught', 'missed', 'missed', 'missed', 'missed'].sample
         event << "#{event.user.display_name} throws a pokeball at #{message}, #{event.user.display_name} #{catch} #{message}"
      end
    end
  end
end

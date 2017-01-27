
module DrawBot
  module DiscordCommands
    # Available actions:
    #
    # - arrest
    # - bad
    # - boop
    # - chop
    # - dance
    # - grope
    # - hug
    # - hump
    # - kick
    # - kiss
    # - lean
    # - lick
    # - murder
    # - noogie
    # - pat
    # - pet
    # - pet
    # - pokeball
    # - punch
    # - rub
    # - sharpie
    # - sit
    # - slap
    # - smack
    # - smell
    # - spray
    # - squeeze
    # - squish
    # - stare
    # - tease
    # - wave
    # - whip
    # - wink

    module Actions
      extend Discordrb::Commands::CommandContainer

      command(:wave,
              description: 'Wave at someone!',
              usage: "#{BOT.prefix}wave @user/something") do |event, *thing|
        thing = thing.join(' ')
        next event.respond "I need the `playful` role and I need to be able to delete messages" unless
        event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
            event << "#{event.user.display_name} waves #{thing}"
         event.message.delete
      end

      command(:smack,
              description: 'Smack someone!',
              usage: "#{BOT.prefix}smack @user/something") do |event, *thing|
        thing = thing.join(' ')
        next event.respond "I need the `playful` role and I need to be able to delete messages" unless
        event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
        event << "#{event.user.display_name} smacks #{thing}"
        event.message.delete
      end

      command(:punch,
              description: 'Punch something!',
              usage: "#{BOT.prefix}punch @user/something") do |event, *thing|
        thing = thing.join(' ')
        next event.respond "I need the `playful` role and I need to be able to delete messages" unless
        event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
        response = Database::Response.where(key:'adverb')
                                     .all.sample.response
        event << "#{event.user.display_name} #{response.sample} punches #{message}"
        event.message.delete
      end

      command(:noogie,
              description: 'Give someone a noogie!',
              usage: "#{BOT.prefix}noogie @user/something") do |event, *thing|
        thing = thing.join(' ')
        next event.respond "I need the `playful` role and I need to be able to delete messages" unless
        event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
         event << "#{event.user.display_name} gives #{message} a noogie"
         event.message.delete
      end

      command(:smell,
              description: 'Smell somone or something!',
              usage: "#{BOT.prefix}smell @user/something") do |event, *thing|
        thing = thing.join(' ')
        next event.respond "I need the `playful` role and I need to be able to delete messages" unless
        event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
                    event << "#{event.user.display_name} smells #{message}"
         event.message.delete
      end

      command(:lick,
              description: 'Lick someone or something!',
              usage: "#{BOT.prefix}like @user/something") do |event, *thing|
        thing = thing.join(' ')
        next event.respond "I need the `playful` role and I need to be able to delete messages" unless
        event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
        response = Database::Response.where(key: 'adverb')
                                     .all.sample.response
            event << "#{event.user.display_name} #{response.sample} licks #{message}"
         event.message.delete
      end

      command(:kick,
              description: 'Kick someone!',
              usage: "#{BOT.prefix}kick @user/something") do |event, *thing|
        thing = thing.join(' ')
        next event.respond "I need the `playful` role and I need to be able to delete messages" unless
        event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
        response = Database::Response.where(key: 'adverb')
                                     .all.sample.response
            event << "#{event.user.display_name} #{response.sample} kicks #{message}"
         event.message.delete
      end

      command(:chop,
              description: 'Karate chop someone!',
              usage: "#{BOT.prefix}chop @user/something") do |event, *thing|
        thing = thing.join(' ')
        next event.respond "I need the `playful` role and I need to be able to delete messages" unless
        event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
        response = Database::Response.where(key: 'adverb')
                                     .all.sample.response
            event << "#{event.user.display_name} #{response.sample} karate chops #{message}"
         event.message.delete
      end

      command(:squeeze,
              description: 'Squeeze someone!',
              usage: "#{BOT.prefix}squeeze @user/something") do |event, *thing|
        thing = thing.join(' ')
        next event.respond "I need the `playful` role and I need to be able to delete messages" unless
        event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
        response = Database::Response.where(key: 'adverb')
                                     .all.sample.response
            event << "#{event.user.display_name} #{response.sample} squeezes #{message}"
         event.message.delete
      end

      command(:arrest,
              description: 'Arrest someone!',
              usage: "#{BOT.prefix}arrest @user/something") do |event, *thing|
        thing = thing.join(' ')
        next event.respond "I need the `playful` role and I need to be able to delete messages" unless
        event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
        response = Database::Response.where(key: 'adverb')
                                     .all.sample.response
            event << "#{event.user.display_name} #{response.sample} arrests #{message}"
         event.message.delete
      end

      command(:sharpie,
              description: 'Draw with a sharpie!',
              usage: "#{BOT.prefix}sharpie @user/something") do |event, *thing|
        thing = thing.join(' ')
        next event.respond "I need the `playful` role and I need to be able to delete messages" unless
        event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
         event << "#{event.user.display_name} draws all over #{message} with a sharpie"
         event.message.delete
      end

      command(:dance,
              description: 'Dance with someone!',
              usage: "#{BOT.prefix}dance @user/something") do |event, *thing|
        thing = thing.join(' ')
        next event.respond "I need the `playful` role and I need to be able to delete messages" unless
        event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
        response = Database::Response.where(key: 'adverb')
                                     .all.sample.response
            event << "#{event.user.display_name} #{response.sample} dances with #{message}"
         event.message.delete
      end

      command(:pat,
              description: 'Pat someone!',
              usage: "#{BOT.prefix}pat @user/something") do |event, *thing|
        thing = thing.join(' ')
        next event.respond "I need the `playful` role and I need to be able to delete messages" unless
        event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
        response = Database::Response.where(key: 'adverb')
                                     .all.sample.response
            event << "#{event.user.display_name} #{response.sample} pats #{message}"
         event.message.delete
      end


      command(:sit,
              description: 'Sit somewhere',
              usage: "#{BOT.prefix}sit @user/something") do |event, *thing|
        thing = thing.join(' ')
        next event.respond "I need the `playful` role and I need to be able to delete messages" unless
        event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
        response = Database::Response.where(key: 'adverb')
                                     .all.sample.response
            event << "#{event.user.display_name} #{response.sample} sits on #{message}"
         event.message.delete
      end

      command(:tease,
              description: 'Tease someone, you meanie!',
              usage: "#{BOT.prefix}tease @user/something") do |event, *thing|
        thing = thing.join(' ')
        next event.respond "I need the `playful` role and I need to be able to delete messages" unless
        event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
        response = Database::Response.where(key: 'adverb')
                                     .all.sample.response
            event << "#{event.user.display_name} #{response.sample} teases #{message}"
         event.message.delete
      end

      command(:whip,
              description: 'Whip someone!',
              usage: "#{BOT.prefix}whip @user/something") do |event, *thing|
        thing = thing.join(' ')
        next event.respond "I need the `playful` role and I need to be able to delete messages" unless
        event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
        response = Database::Response.where(key: 'adverb')
                                     .all.sample.response
            event << "#{event.user.display_name} #{response.sample} whips #{message}"
         event.message.delete
      end

      command(:murder,
              description: 'Murder someone!',
              usage: "#{BOT.prefix}murder @user/something") do |event, *thing|
        thing = thing.join(' ')
        next event.respond "I need the `playful` role and I need to be able to delete messages" unless
        event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
        response = Database::Response.where(key: 'adverb')
                                     .all.sample.response
            event << "#{event.user.display_name} #{response.sample} murders #{message}"
         event.message.delete
      end

      command(:wink,
              description: 'Wink at someone!',
              usage: "#{BOT.prefix}wink @user/something") do |event, *thing|
        thing = thing.join(' ')
        next event.respond "I need the `playful` role and I need to be able to delete messages" unless
        event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
        response = Database::Response.where(key: 'adverb')
                                     .all.sample.response
            event << "#{event.user.display_name} #{response.sample} winks at #{message}"
         event.message.delete
      end

      command(:kiss,
              description: 'Kiss someone!',
              usage: "#{BOT.prefix}kiss @user/something") do |event, *thing|
        thing = thing.join(' ')
        next event.respond "I need the `playful` role and I need to be able to delete messages" unless
        event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
         event << "#{event.user.display_name} gives #{message} a kiss :kiss:"
         event.message.delete
      end

      command(:lean,
              description: 'Lean on something, or someone!',
              usage: "#{BOT.prefix}lean @user/something") do |event, *thing|
        thing = thing.join(' ')
        next event.respond "I need the `playful` role and I need to be able to delete messages" unless
        event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
        response = Database::Response.where(key: 'adverb')
                                      .all.sample.response
            event << "#{event.user.display_name} #{response.sample} leans on #{message}"
         event.message.delete
      end

      command(:squish,
              description: 'Squish things!',
              usage: "#{BOT.prefix}squish @user/something") do |event, *thing|
        thing = thing.join(' ')
        next event.respond "I need the `playful` role and I need to be able to delete messages" unless
        event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
         event << "#{event.user.display_name} squishes #{message}. Quick, grab the broom!"
         event.message.delete
      end

      command(:pokeball,
              description: 'Catch things with pokeballs!',
              usage: "#{BOT.prefix}pokeball @user/something") do |event, *thing|
        thing = thing.join(' ')
        catch = ['caught', 'missed', 'missed', 'missed', 'missed'].sample
        next event.respond "I need the `playful` role and I need to be able to delete messages" unless
        event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
        event << "#{event.user.display_name} throws a pokeball at #{message}, #{event.user.display_name} #{catch} #{message}"
      end

      command(:boop,
              description: 'Boops someone or something',
              usage: "#{BOT.prefix}boop @user/something") do |event, *thing|
              next event.respond "I need the `playful` role and I need to be able to delete messages" unless
              event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
        thing = thing.join(' ')
        response = Database::Response.where(key: 'adverb')
                                      .all.sample.response
        event << "#{event.user.display_name} #{response} boops #{thing}"
        event.message.delete
      end

      command(:slap,
              description: 'Slaps someone or something',
              usage: "#{BOT.prefix}slap @user/something") do |event, *thing|
              next event.respond "I need the `playful` role and I need to be able to delete messages" unless
              event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
        thing = thing.join(' ')
        response = Database::Response.where(key: 'adverb')
                                      .all.sample.response
        event << "#{event.user.display_name} #{response} slaps #{thing}"
        event.message.delete
      end

      command(:rub,
              description: 'Rubs someone or something',
              usage: "#{BOT.prefix}rub @user/something") do |event, *thing|
              next event.respond "I need the `playful` role and I need to be able to delete messages" unless
              event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
        thing = thing.join(' ')
        response = Database::Response.where(key: 'adverb')
                                      .all.sample.response
        event << "#{event.user.display_name} #{response} rubs #{thing}"
        event.message.delete
      end

      command(:grope,
              description: 'Gropes someone or something',
              usage: "#{BOT.prefix}grope @user/something") do |event, *thing|
              next event.respond "I need the `playful` role and I need to be able to delete messages" unless
              event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
        thing = thing.join(' ')
        response = Database::Response.where(key: 'adverb')
                                      .all.sample.response
        event << "#{event.user.display_name} #{response} gropes #{thing}"
        event.message.delete
      end

      command(:hug,
              description: 'Hugs someone or something',
              usage: "#{BOT.prefix}hug @user/something") do |event, *thing|
              next event.respond "I need the `playful` role and I need to be able to delete messages" unless
              event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
        thing = thing.join(' ')
        response = Database::Response.where(key: 'adverb')
                                      .all.sample.response
        event << "#{event.user.display_name} #{response} hugs #{thing}"
        event.message.delete
      end

      command(:hump,
              description: 'Humps someone or something',
              usage: "#{BOT.prefix}hump @user/something") do |event, *thing|
              next event.respond "I need the `playful` role and I need to be able to delete messages" unless
              event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
        thing = thing.join(' ')
        response = Database::Response.where(key: 'adverb')
                                      .all.sample.response
        event << "#{event.user.display_name} #{response} humps #{thing}"
        event.message.delete
      end

      command(:pet,
              description: 'Pet other users!',
              usage: "#{BOT.prefix}pet @user/something") do |event, *message|
        thing = thing.join(' ')
        response = Database::Response.where(key: 'adverb')
                                      .all.sample.response
        event << "#{event.user.display_name} #{response} pets #{message}"
      end

      command(:poke,
              description: 'Poke the other users and annoy them!',
              usage: "#{BOT.prefix}poke @user/something") do |event, *thing|
              next event.respond "I need the `playful` role and I need to be able to delete messages" unless
              event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
        thing = thing.join(' ')
        response = Database::Response.where(key: 'adverb')
                                      .all.sample.response
        event << "#{event.user.display_name} #{response} pokes #{thing}"
        event.message.delete
      end

      command(:pet,
              description: 'Pet other users!',
              usage: "#{BOT.prefix}pet @user/something") do |event, *thing|
              next event.respond "I need the `playful` role and I need to be able to delete messages" unless
              event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
        thing = thing.join(' ')
        response = Database::Response.where(key: 'adverb')
                                      .all.sample.response
        event << "#{event.user.display_name} #{response} pets #{thing}"
        event.message.delete
      end

      command(:spray,
              description: 'Spray other users with various, deadly, weaponry!',
              usage: "#{BOT.prefix}spray @user/something") do |event, *thing|
              next event.respond "I need the `playful` role and I need to be able to delete messages" unless
              event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
        thing = thing.join(' ')
        response = Database::Response.where(key: 'watercontainer')
                                              .all.sample.response
        event << "#{event.user.display_name} sprays #{thing}"\
                  " with a #{response}"
        event.message.delete
      end

      command(:stare,
              description: 'Stare at people, maybe senpai will notice',
              usage: "#{BOT.prefix}stare @user/something") do |event, *thing|
              next event.respond "I need the `playful` role and I need to be able to delete messages" unless
              event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
        thing = thing.join(' ')
        event << "#{event.user.display_name} stares at #{thing}"
        event.message.delete
      end

      command(:bite,
              description: 'Bite other users!',
              usage: "#{BOT.prefix}bite @user/something") do |event, *thing|
              next event.respond "I need the `playful` role and I need to be able to delete messages" unless
              event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
        thing = thing.join(' ')
        response = Database::Response.where(key: 'adverb')
                                      .all.sample.response
        event << "#{event.user.display_name} #{response} bites #{thing}"
        event.message.delete
      end

      command(:bad,
              description: 'Throws people into timeout',
              usage: "#{BOT.prefix}bad @user/something") do |event, *message|
              next event.respond "I need the `playful` role and I need to be able to delete messages" unless
              event.bot.profile.on(event.server).roles.map {|x| x.name }.join.include? 'playful'
        thing = thing.join(' ')
        event << "#{event.user.display_name} throws #{message} into timeout"
        event.message.delete
      end
    end
  end
end

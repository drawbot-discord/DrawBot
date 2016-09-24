module DrawBot
  module DiscordCommands
    # Available actions:
    #
    # - `boop`
    # - `slap`
    # - `rub`
    # - `grope`
    # - `hug`
    # - `hump`
    # - `pet`
    # - `poke`
    # - `spray`
    # - `stare`
    # - `bite`
    # - `bad`
    module Actions
      extend Discordrb::Commands::CommandContainer
      command(:boop,
              description: 'Boops someone or something',
              usage: "#{BOT.prefix}boop something") do |event, *thing|
        thing = thing.join(' ')
        response = Database::Response.where(key: 'adverb')
                                     .all.sample.response
        event << "#{event.user.display_name} #{response} boops #{thing}"
        event.message.delete
      end

      command(:slap,
              description: 'Slaps someone or something',
              usage: "#{BOT.prefix}slap something") do |event, *thing|
        thing = thing.join(' ')
        response = Database::Response.where(key: 'adverb')
                                     .all.sample.response
        event << "#{event.user.display_name} #{response} slaps #{thing}"
        event.message.delete
      end

      command(:rub,
              description: 'Rubs someone or something',
              usage: "#{BOT.prefix}rub something") do |event, *thing|
        thing = thing.join(' ')
        response = Database::Response.where(key: 'adverb')
                                     .all.sample.response
        event << "#{event.user.display_name} #{response} rubs #{thing}"
        event.message.delete
      end

      command(:grope,
              description: 'Gropes someone or something',
              usage: "#{BOT.prefix}grope something") do |event, *thing|
        thing = thing.join(' ')
        response = Database::Response.where(key: 'adverb')
                                     .all.sample.response
        event << "#{event.user.display_name} #{response} gropes #{thing}"
        event.message.delete
      end

      command(:hug,
              description: 'Hugs someone or something',
              usage: "#{BOT.prefix}hug something") do |event, *thing|
        thing = thing.join(' ')
        response = Database::Response.where(key: 'adverb')
                                     .all.sample.response
        event << "#{event.user.display_name} #{response} hugs #{thing}"
        event.message.delete
      end

      command(:hump,
              description: 'Humps someone or something',
              usage: "#{BOT.prefix}hump something") do |event, *thing|
        thing = thing.join(' ')
        response = Database::Response.where(key: 'adverb')
                                     .all.sample.response
        event << "#{event.user.display_name} #{response} humps #{thing}"
        event.message.delete
      end

      command(:pet,
              description: 'Pet other users!',
              usage: "#{BOT.prefix}pet") do |event, *message|
        message = message.join(' ')
        response = Database::Response.where(key: 'adverb').all.sample.response
        event << "#{event.user.display_name} #{response} pets #{message}"
      end

      command(:poke,
              description: 'Poke the other users and annoy them!',
              usage: "#{BOT.prefix}poke") do |event, *thing|
        thing = thing.join(' ')
        response = Database::Response.where(key: 'adverb')
                                     .all.sample.response
        event << "#{event.user.display_name} #{response} pokes #{thing}"
        event.message.delete
      end

      command(:pet,
              description: 'Pet other users!',
              usage: "#{BOT.prefix}pet") do |event, *thing|
        thing = thing.join(' ')
        response = Database::Response.where(key: 'adverb')
                                     .all.sample.response
        event << "#{event.user.display_name} #{response} pets #{thing}"
        event.message.delete
      end

      command(:spray,
              description: 'Spray other users with various, deadly, weaponry!',
              usage: "#{BOT.prefix}spray") do |event, *thing|
        thing = thing.join(' ')
        response = Database::Response.where(key: 'watercontainer')
                                     .all.sample.response
        event << "#{event.user.display_name} sprays #{thing}"\
                 " with a #{response}"
        event.message.delete
      end

      command(:stare,
              description: 'Stare at people, maybe senpai will notice',
              usage: "#{BOT.prefix}stare") do |event, *thing|
        thing = thing.join(' ')
        event << "#{event.user.display_name} stares at #{thing}"
        event.message.delete
      end

      command(:bite,
              description: 'Bite other users!',
              usage: "#{BOT.prefix}bite") do |event, *thing|
        thing = thing.join(' ')
        response = Database::Response.where(key: 'adverb')
                                     .all.sample.response
        event << "#{event.user.display_name} #{response} bites #{thing}"
        event.message.delete
      end

      command(:bad,
              description: 'Throws people into timeout',
              usage: "#{BOT.prefix}bad") do |event, *message|
        message = message.join(' ')
        "#{event.user.display_name} throws #{message} into timeout"
      end
    end
  end
end

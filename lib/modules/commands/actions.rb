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
        event.message.delete
      end
    end
  end
end

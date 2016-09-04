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
    module Actions
      extend Discordrb::Commands::CommandContainer
      command(:boop,
              description: 'Boops someone or something',
              usage: "#{BOT.prefix}boop something") do |event, *thing|
        thing = thing.join(' ')
        response = Database::Response.where(key: 'adverb')
                                     .all.sample.response
        "#{event.user.display_name} #{response} boops #{thing}"
      end

      command(:slap,
              description: 'Slaps someone or something',
              usage: "#{BOT.prefix}slap something") do |event, *thing|
        thing = thing.join(' ')
        response = Database::Response.where(key: 'adverb')
                                     .all.sample.response
        "#{event.user.display_name} #{response} slaps #{thing}"
      end

      command(:rub,
              description: 'Rubs someone or something',
              usage: "#{BOT.prefix}rub something") do |event, *thing|
        thing = thing.join(' ')
        response = Database::Response.where(key: 'adverb')
                                     .all.sample.response
        "#{event.user.display_name} #{response} rubs #{thing}"
      end

      command(:gropes,
              description: 'Gropes someone or something',
              usage: "#{BOT.prefix}grope something") do |event, *thing|
        thing = thing.join(' ')
        response = Database::Response.where(key: 'adverb')
                                     .all.sample.response
        "#{event.user.display_name} #{response} gropes #{thing}"
      end

      command(:hug,
              description: 'Hugs someone or something',
              usage: "#{BOT.prefix}hug something") do |event, *thing|
        thing = thing.join(' ')
        response = Database::Response.where(key: 'adverb')
                                     .all.sample.response
        "#{event.user.display_name} #{response} hugs #{thing}"
      end

      command(:hump,
              description: 'Humps someone or something',
              usage: "#{BOT.prefix}hump something") do |event, *thing|
        thing = thing.join(' ')
        response = Database::Response.where(key: 'adverb')
                                     .all.sample.response
        "#{event.user.display_name} #{response} humps #{thing}"
      end
    end
  end
end

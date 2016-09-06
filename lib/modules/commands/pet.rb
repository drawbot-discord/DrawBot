module DrawBot
  module DiscordCommands
    #Pet other users!
    module Pet
      extend Discordrb::Commands::CommandContainer
      command(:pet,
              description: 'Pet other users!',
              usage: "#{BOT.prefix}pet") do |event, *message|
        message = message.join(' ')
        response = Database::Response.where(key: 'adverb').all.sample.response
        "#{event.user.display_name} #{response} pets #{message}"
      end
    end
  end
end

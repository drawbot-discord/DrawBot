module DrawBot
  module DiscordCommands
    # Adds a response to the database.
    module AddResponse
      extend Discordrb::Commands::CommandContainer
      command(:add_response,
              description: 'Adds a response to the database',
              usage: "#{BOT.prefix}add_response"\
              ' key, response') do |event, *args|
        break unless event.user.id == CONFIG.owner
        args = args.join(' ').split(',').map(&:strip)
        response = Database::Response.create(key: args.first,
                                             response: args.last)
        "Created response! (id: #{response.id},"\
        " ##{Database::Response.where(key: args.first).count})"
      end
    end
  end
end

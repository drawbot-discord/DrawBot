module DrawBot
  module DiscordCommands
    # Deletes a response from the database.
    module DelResponse
      extend Discordrb::Commands::CommandContainer
      command(:del_response,
              description: 'Deletes a response from the database',
              usage: "#{BOT.prefix}del_response id",
              min_args: 1,
              max_args: 1) do |event, id|
        break unless event.user.id == CONFIG.owner
        id = id.to_i
        response = Database::Response.find(id: id)
        unless response.nil?
          response.destroy
          event << "Destroyed response with id: `#{id}`"
          return
        end
        'Response not found in DB..'
      end
    end
  end
end

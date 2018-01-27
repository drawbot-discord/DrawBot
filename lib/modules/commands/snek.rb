module DrawBot
	module DiscordCommands
		module Actions
			extend Discordrb::Commands::CommandContainer
			command(:snek,
				     description: 'Post a random cute snek!'
				     usage: "#{BOT.prefix}snek") do |event|
				response = Database::response.where(key: 'snek')

				event << "#{response}"
				event.message.delete
			end
		end
	end
end

module DrawBot
	module DiscordCommands
		module SillyCommands
			extend Discordrb::Commands::CommandContainer
			command(:snek,
				     description: 'Post a random cute snek!'
				     usage: "#{BOT.prefix}snek") do |event|
				response = Database::response.where(key: 'snek')
				event << "#{response}"
				event.message.delete
			end
            
            command:(pun:,
            	     description: 'Post a silly joke!'
            	     usage: "#{BOT.prefix}pun")
                response = Database::response.where(key: 'pun')
                event << "#{response}"
                event.message.delete
            end

            command:(told:,
            	     description:' Tell someone how told they are.'
            	     usage: "#{BOT.prefix}told")
                response - Database::response.where(key: 'told')
                event << "#{response}"
                event.message.delete
            end

            command:(rekt:,
            	     description:' Tell someone how rekt they are.'
            	     usage: "#{BOT.prefix}rekt")
                response - Database::response.where(key: 'rekt')
                event << "#{response}"
                event.message.delete
            end
		end
	end
end


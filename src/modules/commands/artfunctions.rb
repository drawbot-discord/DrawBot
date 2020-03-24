module Bot
  module DiscordCommands
    # Document your command
    # in some YARD comments here!
    module Person
      extend Discordrb::Commands::CommandContainer
      #result = RestClient.get("https://e621.net/post/index.json?tags=#{tags}")
      #json = JSON.parse(result).sample
      command(:person,
              description: 'Use Drawbot to choose things for you',
              usage: "~pick choice 1, choice 2" ) do |event, *message|
                result = RestClient.get("https://randomuser.me/api/?nat=us,ca,au,nz")
                json = JSON.parse(result)
                "#{json[gender]}"
      end
    end
  end
end

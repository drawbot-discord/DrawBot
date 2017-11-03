module Bot
  module DiscordCommands
    # Document your command
    # in some YARD comments here!
    module Powers
      extend Discordrb::Commands::CommandContainer
      command(:power,
              description: "Generate a random power!",
              usage: `~power`) do |event|
        result = RestClient.get("http://powerlisting.wikia.com/api/v1/Articles/List?expand=1&limit=1000")
        json = JSON.parse(result)
        items = json['items'].sample
        thumb = items['thumbnail']

        event.channel.send_embed do |e|
          e.add_field name: '__**Power**__', value: items['title'] , inline: true
          e.add_field name: "\u200b", value: "[Source](http://powerlisting.wikia.com#{items['url']})", inline: false
          e.image = { url: thumb }
        end
      end
    end
  end
end

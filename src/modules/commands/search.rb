module Bot
  module DiscordCommands
    # Document your command
    # in some YARD comments here!
    module Search
      require 'xmlsimple'
      extend Discordrb::Commands::CommandContainer
      bucket :e621, limit: 3, time_span: 30, delay: 10
      command(:e621, bucket: :e621, rate_limit_message: 'Calm down sweetheart! I can\'t keep up with the lewd!',
              description: "Search for an image on e621.net",
              usage: '~e621 (search_term)') do |event, *tags|
        next event.respond "I'm sorry. I can't do that because this is a SFW channel." unless event.channel.nsfw?
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["e621", "unlocknsfw"]
        next event.respond "I need the `e621` or `unlocknsfw` role for that, silly" if check.empty?
        tags = tags.join(" ")
        next "Give me something to search for" if tags.empty?
        result = RestClient.get("https://e621.net/post/index.json?tags=#{tags}")
        json = JSON.parse(result).sample
          next event.respond 'I couldn\'t find anything, sorry hun.' if json.nil?
        event.channel.send_embed do |e|
          e.add_field name: '__**Artist**__', value: json['artist'][0] , inline: true
          e.add_field name: "\u200b", value: "[Source](https://e621.net/post/show/#{json['file_url']})", inline: true
          e.image = { url: json['file_url'] }
          e.description = "Search result for: `#{tags}`"
        end
      end

      bucket :paheal, limit: 3, time_span: 30, delay: 10
      command(:paheal,
              description: "Search for an image on R34 Paheal",
              usage: `~r34 (search term)`) do |event, *search|
              next event.respond "I'm sorry. I can't do that because this is a SFW channel." unless event.channel.nsfw?
              check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["r34", "unlocknsfw"]
              next event.respond "I need the `r34` or `unlocknsfw` role for that, silly" if check.empty?
              begin
                next event.respond 'Please give me something to look for' if search.empty?
                #The URL the search starts with
                base_url = 'http://rule34.paheal.net/post/list/'
                #Tacks the search arg onto the end of the base_url
                rule34 = Nokogiri::HTML RestClient.get(base_url + search.join('_') + '/1')
                #Uses x to grab the URL from the css
                pictures = rule34.css('.shm-thumb').map do |x|
                  #This produces the img URL from pictures
                  x = x.css('a')[1].attr('href')
                  #y = "https://rule34.paheal.net#{x.css('a')[0].attr('href')}" # This gets the post not a direct image
                end
                next event.respond 'No pictures found' if pictures.empty?
                #Spits out the randomized end result
                event.channel.send_embed do |e|
                e.image  = { url: pictures.sample }
                e.add_field name: "\u200b", value: "[Image](#{pictures.sample})", inline: true
                e.description = "Search result for: `#{search.join(' ')}`"
                e.footer = { text: "Unknown why images are not embedding sometimes"}
                end
              rescue
                event.respond "Couldn't find anything"
              end
      end


      bucket :paheal, limit: 3, time_span: 30, delay: 10
      command(:r34,
              description: "Search for an image on R34 Paheal",
              usage: `~r34 (search term)`) do |event, *tags|
                next event.respond "I'm sorry. I can't do that because this is a SFW channel." unless event.channel.nsfw?
                check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["r34", "unlocknsfw"]
                next event.respond "I need the `e621` or `unlocknsfw` role for that, silly" if check.empty?
                tags = tags.join(" ")
                next "Give me something to search for" if tags.empty?
                result = RestClient.get("https://rule34.xxx/index.php?page=dapi&s=post&q=index&tags=#{tags}")
                xml = XmlSimple.xml_in result
                postcount = xml['count'].to_i
                  next "I couldn\'t find anything, sorry hun." if postcount == 0
                post = xml['post'].sample

                event.channel.send_embed do |e|
                  e.add_field name: "\u200b", value: "[Source](https://rule34.xxx/index.php?page=post&s=view&id=#{post['id']})", inline: true
                  e.image = { url: "https:#{post['file_url']}" }
                  e.description = "Search result for: `#{tags}`"
                end
      end
    end
  end
end

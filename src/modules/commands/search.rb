module Bot
  module DiscordCommands
    # Document your command
    # in some YARD comments here!
    module Search
      extend Discordrb::Commands::CommandContainer
      bucket :e621, limit: 3, time_span: 30, delay: 10
      command(:e621, bucket: :e621, rate_limit_message: 'Calm down sweetheart! I can\'t keep up with the lewd!',
              description: "Search for an image on e621.net",
              usage: '~e621 (search_term)') do |event, *search|
              check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["e621", "unlocknsfw"]
              next event.respond "I need the `e621` or `unlocknsfw` role for that, silly" if check.empty?
              search = search.join('%20')
              next event.respond 'Please give me something to search for' if search.empty?
                base_url = 'https://e621.net/post/index/1/'
                e621 = Nokogiri::HTML RestClient.get(base_url + search)
                pictures = e621.css('.thumb').map do |x|
                x = "https://e621.net#{x.css('a').attr('href')}"
                end
              next event.respond 'I couldn\'t find anything, sorry hun.' if pictures.empty?
                bigimage_page = Nokogiri::HTML RestClient.get(pictures.sample)
                bigimage = bigimage_page.css('.content').css('img').map do |x|
                  x.attr('src')
              end
              event.channel.send_embed do |e|
              e.image  = { url: bigimage[1] }
              e.description = "Search result for: `#{search}`"
          end
          event.message.delete
      end

      bucket :r34, limit: 3, time_span: 30, delay: 10
      command(:paheal,
              description: "Search for an image on R34 Paheal",
              usage: `~r34 (search term)`) do |event, *search|
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
    end
  end
end

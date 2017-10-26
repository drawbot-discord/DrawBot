module Bot
  module DiscordCommands
    # Document your command
    # in some YARD comments here!
    module Pokemon
      extend Discordrb::Commands::CommandContainer
      bucket :pokemon, limit: 3, time_span: 30, delay: 10
      command(:pokemon, bucket: :pokemon, rate_limit_message: 'Too much Pokemon!',
               description: "Gets a random pokemon for you to draw",
               usage: '~pokemon') do |event|
        i = rand(0..720)
        img = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/#{i.next}.png"
        pkmn = JSON.parse(RestClient.get("https://pokeapi.co/api/v2/pokemon/?limit=1&offset=#{i}"))
        event.channel.send_embed do |e|
          e.add_field name: "Your pokemon to draw is: **#{pkmn['results'][0]['name'].split.map(&:capitalize).join(' ')}**",
                      value: "\u200b", inline: true
          e.image = { url: img }
        end

      end

      bucket :pokevs, limit: 3, time_span: 30, delay: 10
      command(:pokevs, bucket: :pokevs, rate_limit_message: 'Too much Poke-abuse!',
              description: "Gets a random pokemon to fight",
              usage: '~pokevs') do |event|
        i = rand(0..720)
        u = rand(0..720)
        level = rand(1..100)
        level2 = rand(1..100)
        img = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/#{i.next}.png"
        img2 = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/#{u.next}.png"
        pkmn = JSON.parse(RestClient.get("https://pokeapi.co/api/v2/pokemon/?limit=1&offset=#{i}"))
        pkmn2 = JSON.parse(RestClient.get("https://pokeapi.co/api/v2/pokemon/?limit=1&offset=#{u}"))
        event.channel.send_embed do |e|
          e.add_field name: "A level #{level} **#{pkmn['results'][0]['name'].split.map(&:capitalize).join(' ')}** ",
                      value: "\u200b", inline: true
          e.add_field name: "VERSUS",
                      value: "\u200b", inline: false
          e.add_field name: "A level #{level2} **#{pkmn2['results'][0]['name'].split.map(&:capitalize).join(' ')}**",
                      value: "\u200b", inline: false
          e.thumbnail = { url: img }
          e.image = { url: img2 }
        end
      end
    end
  end
end

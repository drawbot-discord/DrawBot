module Bot
  module DiscordCommands
    # Document your command
    # in some YARD comments here!
    module Person
      extend Discordrb::Commands::CommandContainer
      $personality = YAML.load(File.read('data/personality.yaml'))

      moodpos = $personality['moodpos'].sample
      moodneg = $personality['moodneg'].sample

      command(:person,
              description: 'Use Drawbot to choose things for you',
              usage: "~pick choice 1, choice 2" ) do |event, *message|
                info = RestClient.get("https://randomuser.me/api/?nat=us,ca,au,nz")
                json = JSON.parse(info)
                rslt = json['results'].first

                street = "#{rslt['location']['street']['number']} #{rslt['location']['street']['name']}"
                dob_date = Time.parse(rslt['dob']['date'])
                dob = "#{dob_date} (Age: #{rslt['dob']['age']})"
                
                event.channel.send_embed do |e|
                  e.thumbnail = { url: rslt['picture']['large'] }
                  e.add_field name: "Random #{rslt['gender'].capitalize}",
                              value: "#{rslt['name']['title']} "\
                                     "#{rslt['name']['first']} "\
                                     "#{rslt['name']['last']}", inline: true
                  e.add_field name: "Location",
                              value: "#{street}\n\n"\
                                     "#{rslt['location']['city']}, "\
                                     "#{rslt['location']['state']}, "\
                                     "#{rslt['location']['postcode']} "\
                                      + "#{rslt['nat'].upcase}", inline: false
                  e.add_field name: "Personal Info",
                              value: "D.O.B: #{dob}", inline: true
                  e.add_field name: "Login Details",
                              value: "Username: #{rslt['login']['username']}\n"\
                                     "Email: #{rslt['email']}\n", inline: false
                end
      end
      command([:personality, :pers]) do |event|
        pos, pos2, pos3, = $personality['pos'].sample(3)
        moodpos =  $personality['moodpos'].sample
        moodneg =  $personality['moodneg'].sample
        adverb = ["always",  "largely", "chiefly", "predominantly", "principally", "primarily", "mostly", "most of the time"]
        event.channel.send_embed do |e|
          e.add_field name: 'Random Personality',
                     value: "You are __#{pos['trait']}__¹ and __#{pos2['trait']}__². "\
                            "But #{adverb.sample} you're __#{pos3['trait']}__³ \n"\
                            "#{pos['desc'].sample}¹ #{pos2['desc'].sample}² #{pos3['desc'].sample}³" , inline: true

         e.add_field name: "\u200b",
                     value: "Typically you're always in a "\
                            "__#{moodpos['trait']}__ mood.\n"\
                            "#{moodpos['desc'].sample}\n"\
                            "Sometimes though you're in a __#{moodneg['trait']}__"\
                            " mood. #{moodneg['desc'].sample}", inline: true
        end
      end
    end
  end
end


#{"results"=>[{"gender"=>"female", "name"=>{"title"=>"mrs", "first"=>"gloria", "last"=>"powell"}, "location"=>{"street"=>"7833 lakeshore rd", "city"=>"charlotte", "state"=>"nebraska", "postcode"=>53412}, "email"=>"gloria.powell@example.com", "login"=>{"username"=>"ticklishgorilla467", "password"=>"freeuser", "salt"=>"Abs7oobC", "md5"=>"24a88f978a8f11e9e741923c5837b519", "sha1"=>"f99b3f79788ba9ada434b34992d9348020a67b3b", #"sha256"=>"a27f9e954a84d9d75357389188d29d30ac21fd767c107da58ffe51c2b53d280a"}, "dob"=>"1994-01-19 02:34:13", "registered"=>"2009-04-22 01:41:21", "phone"=>"(195)-927-9432", "cell"=>"(676)-177-1360", "id"=>{"name"=>"SSN", "value"=>"919-68-4243"}, "picture"=>{"large"=>"https://randomuser.me/api/portraits/women/61.jpg", "medium"=>"https://randomuser.me/api/portraits/med/women/61.jpg", "thumbnail"=>"https://randomuser.me/api/portraits/thumb/women/61.jpg"}, "nat"=>"US"}], #"info"=>{"seed"=>"998f67c61752db5d", "results"=>1, "page"=>1, "version"=>"1.1"}}


#    string = '{"desc":{"someKey":"someValue","anotherKey":"value"},"main_item":{"stats":{"a":8,"b":12,"c":10}}}'
#    parsed = JSON.parse(string) # returns a hash

#    p parsed["desc"]["someKey"]
#    p parsed["main_item"]["stats"]["a"]

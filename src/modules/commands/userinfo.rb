module Bot
  module DiscordCommands
    # Document your command
    # in some YARD comments here!
    module UserInfo
      extend Discordrb::Commands::CommandContainer
      module_function
      $bank = YAML.load(File.read('data/userinfo.yaml'))


      command(:bank, bucket: :bank, rate_limit_message:'I can\'t spread the wealth that fast!',
                   description: "Fetches your balance, or @user's balance") do |event, mention|
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["banker", "unlocksfw"]
        next event.respond "I need the `banker` or `unlocksfw` role for that, silly" if check.empty?
           def save
             file = File.open("bank.yaml", "w")
             file.write($bank.to_yaml)
           end
         begin
         user = $bank['users'][event.user.id]
         if user == true
         event << "You're already registered sweetheart."
         end
         if user.nil?
         $bank['users'][event.user.id] = Hash["name" => event.user.display_name, "refs" => [], "hearts" => 0, "salt" => 0, "stipend" => 25]
         event << "User added! You now have `0 HEARTS`, `0 SALT`, `25 STIPEND`, and can add refs!"
         save
         nil
         end
         rescue => e
         puts e
         end



         if mention.nil?
           mention = event.user.id.to_i
         else
           mention = event.message.mentions.at(0).id.to_i
         end

          #load user from $bank, report if user is invalid or not registered.
          user = $bank["users"][mention]
          if user.nil?
            event << "User does not exist, sorry sweety."
            return
          end

          #report bank
          total = user['hearts'] + user['salt']
          percent_hearts = (user['hearts'].to_f / total.to_f) * 100.0
          percent_hearts = percent_hearts.round(2)
          percent_salty = (user['salt'].to_f / total.to_f) * 100.0
          percent_salty = percent_salty.round(2)
          event << "You are **#{percent_hearts}%** lovely :kissing_heart: and **#{percent_salty}%** salty! :unamused:"
          event << ""
          event << "Heart balance: #{user['hearts']}"
          event << "Salt balance: #{user['salt']}"
          event << "Stipend balance: #{user['stipend']}"

         nil
      end





      command(:give, min_args: 3,
                  description: "give currency",
                  usage: '~give @user # hearts or salt') do |event, to, value, type|
        next event.respond "I need the `banker` role for that, silly" unless
        check = event.bot.profile.on(event.server).roles.map {|x| x.name }  & ["banker", "unlocksfw"]
        next event.respond "I need the `banker` or `unlocksfw` role for that, silly" if check.empty?
         value = value.to_i

            #checks to make sure people aren't stealing (giving negative values)
         next "No negatives allowed" if value < 1
            #pick up user
          fromUser = $bank["users"][event.user.id]

          #return if invalid user
          if fromUser.nil?
            event << "User does not exist :x:"
            return
          end

          #check if they have enough first
          if (fromUser["stipend"] - value) < 0
            event << "You do not have enough currency to make this transaction. :disappointed_relieved:"
            return
          end


          #pick up user to receive currency
          toUser = $bank["users"][event.bot.parse_mention(to).id]

          if toUser == event.bot.profile.id
            event << "Is that all you have to offer, hun?"
            event << "https://i.imgur.com/SZAppZR.jpg"
            return
          end


          #check that they exist
          if toUser.nil?
            event << "User does not exist :x:"
            return
          end

          if fromUser == toUser
            event << "You can't give yourself things, sweety."
           return
          end

        #transfer currency
        #remove from stipend
        fromUser["stipend"] -= value

        #give toUser the desired currency
        if type == 'salt'
            toUser['salt'] += value
          elsif type == 'hearts'
            toUser['hearts'] += value

        else
          event << "Hey hun? Choose `salt` or `hearts`, I can't do that for you!"
          return
        end

        #notification
        event << "**#{event.user.display_name}** awarded **#{event.message.mentions.at(0).on(event.server).display_name}** with **#{value.to_s} #{type}** :yum:"
        def save
          file = File.open("bank.yaml", "w")
          file.write($bank.to_yaml)
        end
        save
          nil
      end

      command(:refs,
              description: "Get the reference of a fellow artist!",
              usage: '~refs @user') do |event, mention|
        user = $bank['users'][event.bot.parse_mention(mention).id]

        if mention.nil?
          user = event.user.id.to_i
          return
        end

        if user.nil?
          event << "User not found.. sorry sweetheart!"
          return
        end

        if user['refs'].nil?
          event << "They don't have a ref, yet"
          return
        end

        event << "#{user['name']}'s refs:"
        user['refs'].each { |x| event << x }
        nil
      end

      command(:addref,
              description: 'Add a reference for yourself or your character!',
              usage: "`~addref (URL)`") do |event, url|
                  def save
                    file = File.open("db.yaml", "w")
                    file.write($bank.to_yaml)
                  end
        user = $bank['users'][event.user.id]
               if user.nil?
             $bank['users'][event.user.id] = Hash["name" => event.user.display_name, "refs" => [], "hearts" => 0, "salt" => 0, "stipend" => 25]
                 event << "User added"
               end
        user = $bank['users'][event.user.id]
             user['refs'] << url.to_s
             event << "Ref added! :wink:"
             save
             nil
      end
    end
  end
end

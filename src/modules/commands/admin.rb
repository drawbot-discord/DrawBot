module Bot
  module DiscordCommands
    # Command for evaluating Ruby code in an active bot.
    # Only the `event.user` with matching discord ID of `CONFIG.owner`
    # can use this command.
    module Admincommands
      extend Discordrb::Commands::CommandContainer
      module_function
      $userinfo = YAML.load(File.read('data/userinfo.yaml'))
      command(:eval, help_available: false) do |event, *code|
        break unless event.user.id == CONFIG.owner
        begin
          eval code.join(' ')
        rescue => e
          "An error occurred 😞 ```#{e}```"
        end
      end

      command(:restart, help_available: false) do |event|
              break unless event.user.id == CONFIG.owner
            event.channel.send_message("Sure thing hun!")
            event.channel.send_message("Restart issued.. :wrench:")
            system('git pull')
        exit
      end

      command(:setbank, min_args: 3, description: "sets @user's bank and stipend balance") do |event, mention, hearts, salt, stipend|
        break unless event.channel.id == CONFIG.owner
        def save
          file = File.open("data/userinfo.yaml", "w")
          file.write($userinfo.to_yaml)
        end
         hearts = hearts.to_i
         salt = salt.to_i
         stipend = stipend.to_i

        #update $db with requested values
         user = $userinfo['users'][event.bot.parse_mention(mention).id]
         user['salt'] = salt
         user['hearts'] = hearts
         user['stipend'] = stipend

        #notification
        event << "Updated! :wink:"

        save
        nil
      end

      command(:todo, help_available: false) do |event, *message|
         break unless event.user.id == CONFIG.owner
          message = message.join(' ')
          num = event.message.id
            event.bot.channel(322615736717672450).send_embed do |e|
              e.add_field name: 'To-Do', value: "#{message}", inline: true
              e.add_field name: '__**Created in**__', value: "Server: #{event.server.name}\n"\
                                                             "Channel: #{event.channel.name}", inline: false
              e.footer = { text: "Ref number #{num}" }
            end
          "New thing added to your To Do list hun!\n"\
          "Ref Number `#{num}`"
      end
    end
  end
end

module Bot
  module DiscordCommands
    # Document your command
    # in some YARD comments here!
    module ArtCommands
      extend Discordrb::Commands::CommandContainer

      command(:suggest,
              description: "Suggest something to the bot developer",
              usage: `~suggest "suggestion here"`) do |event, *message|
          message = message.join(' ')
          num = event.message.id
            event.bot.channel(404797071129051138).send_embed do |e|
              e.add_field name: 'New suggestion', value: "#{message}", inline: true
              e.add_field name: '__**Created in**__', value: "Server: #{event.server.name}\n"\
                                                             "Channel: #{event.channel.name}\n"\
                                                             "User: #{event.user.name}", inline: false
              e.footer = { text: "Ref number #{num}" }
            end
          "New thing added to your To Do list hun!\n"\
          "Ref Number `#{num}`"
      end
    end
  end
end

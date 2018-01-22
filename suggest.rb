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
        event.channel.send_embed do |e|
          e.add_field name: "\u200b", value: "I went ahead and let Echo know about your idea!\n"\
                                             "[Be sure to join my development server to discuss your idea.](https://discord.gg/u3a2Ck9)\n"\
                                             "Ref Number `#{num}`", inline: true
        end
      end
    end
  end
end

module Drawbot
  module DiscordCommands
    module Colours
      extend Discordrb::Commands::CommandContainer

       command(:colour,
               description: 'Generate a random set of complementary colours!',
               usage: "#{BOT.prefix}colour")
              response = Database::Response.where(key: 'colour').all.sample.response
              "#{event.user.display_name}, your complementary colours are"
              "#{response}"
       end

       command(:color,
               description: 'Generate a random set of complementary colors!',
               usage: "#{BOT.prefix}colour")
              response = Database::Response.where(key: 'color').all.sample.response
              "#{event.user.display_name}, your complementary colors are"
              "#{response}"
              "You yankee!"
       end


       command(:colourshade,
               description: 'Generate shades of a random colour',
               usage: "#{BOT.prefix}colour")
              response = Database::Response.where(key: 'colourshade').all.sample.response
              "#{event.user.display_name}, your colour shades are"
              "#{response}"
       end

       command(:colorshade,
               description: 'Generate shades of a random color',
               usage: "#{BOT.prefix}colour")
              response = Database::Response.where(key: 'colourshade').all.sample.response
              "#{event.user.display_name}, your colour shades are"
              "#{response}"
              "You Yankee!"
       end
    end
  end
end
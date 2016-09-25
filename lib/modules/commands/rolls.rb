#Roll command
module DrawBot
  module DiscordCommands
    module Rolls
     bot.command(:roll,
                 description: 'Roll assorted dice!',
                 usage: "#{BOT.prefix}roll") do |event, roll|
     roll = roll.split('d').map(&:to_i)
     roll = roll[0].times.collect { |x| rand(1..roll[1]) }
     total = roll.inject(0){|sum,x| sum + x }
     "#{event.user.display_name} throws their dice down\
                and roll `#{roll.join(', ')} = #{total}`"
     end                  
    end
  end
end

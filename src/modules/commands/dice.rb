module Bot
  module DiscordCommands
    # Document your command
    # in some YARD comments here!
    module MyCommand
      extend Discordrb::Commands::CommandContainer
        command :roll do |event, *dice|
        def is_numeric?(obj)
          obj.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
        end
        if is_numeric?(dice)
          die = rand(1..dice.to_i)
            puts "#{name} rolls thier dice and rolls #{die}"
        end

        if (dice != '0') && (dice.to_i.to_s != dice.strip)
          # input is not a number
          if dice.empty?
            roll = rand(1..20)
            "#{name} throws their D20 down and rolls `#{roll}`"
          #input is #d#
          else
            roll = dice.split('d').map(&:to_i)                   # => [1, 20] 1d20 gets split into [1, 20]
            die = roll[0].times.collect { |x| rand(1..roll[1]) } # => [1, 3] (Random Numbers)
            total = die.inject(0){|sum,x| sum + x }
            "#{name} throws their dice down and rolls `#{roll.join(', ')} = #{total}`"
          end
        end
      end
    end
  end
end

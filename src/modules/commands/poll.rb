module Bot
  module DiscordCommands
    # Document your command
    # in some YARD comments here!
    module Poll
      extend Discordrb::Commands::CommandContainer
      command(:poll, help_available: true,
              description: "Does a poll that ends after 2min or the set time, can have up to 5 options seperated with a \'-\'",
              usage: "poll 20min <option 1> - <option 2>` (from 1min to 60min don't forget the 'min')`", min_args: 1) do |event, *message|
              reactions = %w(🇦 🇧 🇨 🇩 🇪 🇫 🇬 🇭 🇮 🇯)
              time = '2m'
              next event.respond 'I can only count to 60min :sweat: sorry' unless message[0].strip =~ /^[1-5]\dm|^60m|^\dm/i
              time = message.shift if message[0].strip =~ /^[1-5]\dm|^60m|^\dm/i
              message = message.join(' ')
              options = message.split('-')
              next event.respond 'I can only count up to 10 options :stuck_out_tongue_closed_eyes:' if options.length > 10
              next event.respond 'I need at least one option :thinking:' if options.empty?
              eachoption = options.map.with_index { |x, i| "#{reactions[i]}. #{x.strip.capitalize}" }
              output = eachoption.join("\n")
              poll = event.respond "Starting poll for: (Expires in: #{time})\n#{output}"
              reactions[0...options.length].each do |r|
                poll.react r
              end
              time = time.to_i * 60
              while time > 0
                sleep 30
                time -= 30
                poll.edit "Starting poll for: (Remaining time: #{time.to_f / 60}m)\n#{output}"
              end
              values = event.channel.message(poll.id).reactions
              winning_score = values.collect(&:count).max
              winners = values.select { |r| r.count == winning_score if reactions.include? r.name }
              result = ''
              result << 'Options: '
              reactions[0...options.length].each_with_index do |x, i|
                result << "#{x} = `#{options[i].strip.capitalize}`  "
              end
              result << "\n"
              result << 'Winner(s):'
              winners.each do |x|
                result << " #{x.name} with #{x.count - 1} vote(s)"
              end
              # reactions[0...options.length].each_with_index do |x, i|
              # result << "#{x} `#{options[i].strip.capitalize}` had #{event.channel.message(poll.id).reactions[x].count} vote(s)  "
              # end
              # result << "\n"
              event.respond result
      end
    end
  end
end

module Bot
  module DiscordCommands
    # Document your command
    # in some YARD comments here!
    module Pick
      extend Discordrb::Commands::CommandContainer
      command(:pick,
              description: 'Use Drawbot to choose things for you',
              usage: "~pick choice 1, choice 2" ) do |event, *message|
        pickmessage = message.join(' ').split(',')
        event << "#{event.user.mention}, I choose;"
        event << "#{pickmessage.sample}"
      end
    end
  end
end

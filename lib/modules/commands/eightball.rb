module DrawBot
  module DiscordCommands
    # Gives a random Zii fortune, without the image.
    module Eightball
      extend Discordrb::Commands::CommandContainer
      command(:'8ball',
              description: 'Gives you a random fortune',
              usage: "#{BOT.prefix}8ball question") do |event, *args|
        args = args.join(' ')
        zii = Database::Zii.where(fortune: nil).invert.all.sample
        event << if args.empty?
                   "#{event.user.mention} #{zii.fortune}"
                 else
                   "#{event.user.mention} `#{args}`: #{zii.fortune}"
                 end
      end
    end
  end
end

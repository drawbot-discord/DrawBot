module DrawBot
  module DiscordCommands
    # Gives a random Zii fortune.
    module Zii
      extend Discordrb::Commands::CommandContainer
      command(:zii,
              description: 'Gives you a random Zii fortune',
              usage: "#{BOT.prefix}zii question") do |event, *args|
        args = args.join(' ')
        zii = Database::Zii.where(image_url: nil).invert.all.sample
        event << "#{event.user.mention} #{zii.image_url}"
        event << if args.empty?
                   zii.fortune
                 else
                   "`#{args}`: #{zii.fortune}"
                 end
      end
    end
  end
end

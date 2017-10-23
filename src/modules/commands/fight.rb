module Bot
  module DiscordCommands
    # Document your command
    # in some YARD comments here!
    module MyCommand
      extend Discordrb::Commands::CommandContainer
      command :fight do |event, *message|
        message = message.join(" ")
      a = rand(1..20)
      b = rand(1..20)
      extremecondition = ["extreme force", "with a nuke"]
      killcondition = [
        "with a hammer",
        "with a hatchet",
        "with a dick",
        "by sacrifice to the Lord of Terror",
        "telefragged",
        "with a 360NoScope",
        "with a stick of dynamite",
        "with a lobotomy",
        "with a fish",
        "with a shovel",
        "with a pencil",
        "with a pinecone",
        "with fists"]
      roll = "#{event.user.name}: #{a}\n#{message}: #{b}"
      result = "#{event.user.name} killed #{message} #{killcondition.sample}" if a > b
      result = "#{message} killed #{event.user.name} #{killcondition.sample}" if a < b
      result = "#{event.user.name} killed #{message} #{extremecondition.sample}" if a == 20
      result = "#{message} killed #{event.user.name} #{extremecondition.sample}" if b == 20
      result = "It's a tie! RE-ROLL!" if a == b
        event.channel.send_embed do |e|
          e.description = "**#{result}**"
          e.add_field name: "\u200b", value: roll, inline: true
        end
        event.message.delete
      end
    end
  end
end

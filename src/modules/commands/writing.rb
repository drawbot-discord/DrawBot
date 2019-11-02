
module Bot
  module DiscordCommands
    # Document your command
    # in some YARD comments here!
    module Writing
      extend Discordrb::Commands::CommandContainer
      $wl = YAML.load(File.read('data/wl.yaml'))
      $prompt = YAML.load(File.read('data/prompt.yaml'))
      $graff = YAML.load(File.read('data/graff.yaml'))

      command(:word,
               description: "Generate a random set of words",
               usage: '~word') do |event, *message|
        "You get the following words:\n"\
        "\n#{$wl['list'].sample(5).join("\n")}"
      end

      command(:prompt,
               description: "Generate a random story prompt",
               usage: '~prompt') do |event, *message|
        event.channel.send_embed do |e|
         e.add_field name: '__**Story Prompt**__', value: "#{$prompt['prompt'].sample}", inline: true
         e.add_field name: '__**Story Mood**__', value: "#{$prompt['mood'].sample}", inline: false
        end
      end


      command(:graff,
               description: "Generate a random set of words 3-5 characters in length",
               usage: '~graff') do |event|
        "You get the following words:\n"\
        "\n#{$graff['LIST'].sample(5).join("\n")}"
      end
    end
  end
end

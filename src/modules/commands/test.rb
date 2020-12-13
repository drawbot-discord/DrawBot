module Bot
  module DiscordCommands
    # Document your command
    # in some YARD comments here!
    module TestCommands
    module_function
      extend Discordrb::Commands::CommandContainer
      $pcname = YAML.load(File.read('data/pcname.yaml'))
      command :test do |event, input|
        races = $pcname['races']
        if input.nil?
          event.channel.send_embed do |e|
            #e.add_field name: '__Races__',
            #            value: races.map { |r| r.capitalize }.join("\n"), inline: true
            e.add_field name: '__You can choose from the following races__',
                        value: count, inline: true
          end
          break
        end

        if races.include?(input.downcase)
          input = input.downcase.gsub(/-/,'')
          inputm = input + "m"
          inputf = input + "f"
          event.channel.send_embed do |e|
            e.add_field name: "__**#{input.capitalize} Male**__",
                       value: 10.times.collect { send(:"#{inputm}") }.join("\n"),
                      inline: true
            e.add_field name: "\u200b",
                       value: "\u200b",
                      inline: true
            e.add_field name: "__**#{input.capitalize} Female**__",
                       value: 10.times.collect { send(:"#{inputf}") }.join("\n"),
                      inline: true
          end
        else
        "Either I don't have that race yet, or there's a typo. Sorry sweetheart."
        end
      end
    end
  end
end

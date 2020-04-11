module Bot
  module DiscordCommands
    # Document your command
    # in some YARD comments here!
    module Character
      extend Discordrb::Commands::CommandContainer
      $character = YAML.load(File.read('data/character.yaml'))
      $pc = YAML.load(File.read('data/pc.yaml'))
      command(:names,
               description: "Generate 10 random names from a 1990 census, 5 male, 5 female and 5 fantasy names",
               usage: '~names') do |event|
           event.channel.send_embed do |e|
            e.description = "#{event.user.name}, your random names are:"
            e.add_field name: "__**Male**__", value: "#{$character['malenames'].sample(5).join("\n")}", inline: true
            e.add_field name: "__**Female**__", value: "#{$character['femalesnames'].sample(5).join("\n")}", inline: true
            e.add_field name: "__**Fantasy Names**__", value: "#{$character['fantasynames'].sample(5).join("\n")}", inline: true
          end
        event.message.delete
      end

      command(:fantasyname,
               description: "Generate a random fantasy name!",
               usage: '~fantasyname') do |event|
           event.channel.send_embed do |e|
            e.description = "#{event.user.name}, your random fantasy names are:"
            e.add_field name: "\u200b", value: "#{$character['fantasynames'].sample(5).join("\n")}", inline: true
          end
        event.message.delete
      end

      command([:randomchar, :pc],
               description: "Generate a random fantasy character (Pathfinder/DnD)",
               usage: '~randomchar') do |event|

        pc_class = $pc['class'].sample
        pc_class_case = pc_class['pcclass']
        align = (pc_class_case == 'paladin') ? 'Lawful Good' : $pc['align'].sample
        gender = ['He', 'She'].sample
        pronoun = case gender
                  when "He"
                    "His"
                  when "She"
                    "Her"
                  else
                    "their"
                  end
        icon = pc_class['icon']
        weapon = generate_weapon(pc_class_case)
        deity = generate_deity(align)
        race = $pc['race'].sample.capitalize

        event.channel.send_embed do |e|
        e.thumbnail = { url: icon }
        e.description = "A #{align} #{race} #{pc_class_case}"\
               " #{$pc['stats'].sample}. #{gender} has #{$pc['hairlength'].sample}"\
               " #{$pc['hair'].sample} hair, #{$pc['bodytype'].sample}"\
               " body and #{$pc['height'].sample}."\
               " #{pronoun} weapon of choice is #{weapon}.\n\n"\
               "#{$pc['birth'].sample}"\
               " But not everyone is perfect #{$pc['drawback'].sample}"
        e.add_field name: '__**Alignment**__', value: align, inline: true
        e.add_field name: '__**Race**__', value: race, inline: true
        e.add_field name: '__**Class**__', value: pc_class_case.capitalize, inline: true
        e.add_field name: '__**Names**__', value: "#{$character['fantasynames'].sample(3).join(", ")}"
        e.add_field name: "__**Deity**__", value: deity, inline: true
        e.add_field name: "__**Romance**__", value: romanticrelation, inline: true
        e.description = '__Randomly generated character sheet__'
        e.add_field name: '__**Description**__',
                    value: "A #{align} #{race} #{pc_class_case}"\
                           " #{$pc['stats'].sample}. #{gender} has #{$pc['hairlength'].sample}"\
                           " #{$pc['hair'].sample} hair, #{$pc['bodytype'].sample}"\
                           " body and #{$pc['height'].sample}."\
                           " #{pronoun} weapon of choice is #{weapon}.\n", inline: true
        e.add_field name: "\u200b",
                    value: "#{$pc['birth'].sample} #{$pc['adolesence'].sample} #{$pc['childhood'].sample}"\
                           " But not everyone is perfect.. #{$pc['drawback'].sample}", inline: true
        end
      end
    end
  end
end

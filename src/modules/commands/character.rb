
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
           gender = ["He", "She"].sample
           pronoun =
           case gender
           when "He"
             then "His"
           when "She"
             then "Her"
           else "their"
           end

           pcclass = $pc['class'].sample
           pclasscase = pcclass["pcclass"]
           icon = pcclass['icon']
           race = "#{$pc['race'].sample.capitalize}"

           align =
           case pclasscase
             when "paladin"
               then "Lawful Good"
             else $pc['align'].sample
           end

           deity =
           case align
             when "Lawful Good"
               then "#{$pc['lgdeity'].sample(3).join(", ")}"
             when "Lawful Neutral"
               then "#{$pc['lndeity'].sample(3).join(", ")}"
             when "Lawful Evil"
                then "#{$pc['ledeity'].sample(3).join(", ")}"
             when "Neutral"
               then "#{$pc['ndeity'].sample(3).join(", ")}"
             when "Neutral Good"
               then "#{$pc['ngdeity'].sample(3).join(", ")}"
             when "Neutral Evil"
               then "#{$pc['nedeity'].sample(3).join(", ")}"
             when "Chaotic Good"
               then "#{$pc['cgdeity'].sample(3).join(", ")}"
             when "Chaotic Neutral"
               then "#{$pc['cndeity'].sample(3).join(", ")}"
             when "Chaotic Evil"
               then "#{$pc['cedeity'].sample(3).join(", ")}"
             else $pc['deity'].sample(3).join(", ")
           end
           weapon =
           case pclasscase
           when "barbarian", "fighter", "paladin", "ranger", "cavalier",\
                "gunslinger", "magus", "vigilante", "bloodrager", "skald",\
                "slayer", "swashbuckler", "warpriest", "hunter"
               then $pc['simpmart'].sample
             when "cleric", "sorcerer", "alchemist",\
                  "oracle", "summoner", "witch", "arcanist"
               then $pc['simple'].sample
             when "bard"
               then $pc['bardwep'].sample
             when "inquisitor"
               then $pc['inquisitorwep'].sample
             when "rogue"
               then $pc['roguewep'].sample
             when "brawler"
               then $pc['brawlerwep'].sample
             when "investigator"
               then $pc['investigatorwep'].sample
             when "druid"
               then $pc['druidwep'].sample
             when "monk"
               then $pc['monkwep'].sample
             when "wizard"
               then $pc['wizardwep'].sample
            else $pc['simpmart'].sample
           end

        event.channel.send_embed do |e|
        e.thumbnail = { url: icon }
        e.description = "A #{align} #{race} #{pclasscase}"\
               " #{$pc['stats'].sample}. #{gender} has #{$pc['hairlength'].sample}"\
               " #{$pc['hair'].sample} hair, #{$pc['bodytype'].sample}"\
               " body and #{$pc['height'].sample}."\
               " #{pronoun} weapon of choice is #{weapon}.\n\n"\
               "#{$pc['birth'].sample}"\
               " But not everyone is perfect #{$pc['drawback'].sample}"
        e.add_field name: '__**Alignment**__', value: align, inline: true
        e.add_field name: '__**Race**__', value: race, inline: true
        e.add_field name: '__**Class**__', value: pclasscase.capitalize, inline: true
        e.add_field name: '__**Names**__', value: "#{$character['fantasynames'].sample(3).join(", ")}"
        e.add_field name: "__**Deity**__", value: deity, inline: true
        e.description = '__Randomly generated character sheet__'
        e.add_field name: '__**Description**__',
                    value: "A #{align} #{race} #{pclasscase}"\
                           " #{$pc['stats'].sample}. #{gender} has #{$pc['hairlength'].sample}"\
                           " #{$pc['hair'].sample} hair, #{$pc['bodytype'].sample}"\
                           " body and #{$pc['height'].sample}."\
                           " #{pronoun} weapon of choice is #{weapon}.\n\n"\
                           "#{$pc['birth'].sample} #{$pc['adolesence'].sample} "\
                           " But not everyone is perfect.. #{$pc['drawback'].sample}", inline: true
        end
      end
    end
  end
end

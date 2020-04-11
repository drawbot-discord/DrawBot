module Bot
  module DiscordCommands
    # Document your command
    # in some YARD comments here!
    module Character
    module_function
      extend Discordrb::Commands::CommandContainer
      $character = YAML.load(File.read('data/character.yaml'))
      $pc = YAML.load(File.read('data/pc.yaml'))

      def generate_deity(align)
        return case align
               when "Lawful Good"
                 "#{$pc['lgdeity'].sample(3).join(", ")}"
               when "Lawful Neutral"
                 "#{$pc['lndeity'].sample(3).join(", ")}"
               when "Lawful Evil"
                 "#{$pc['ledeity'].sample(3).join(", ")}"
               when "Neutral"
                 "#{$pc['ndeity'].sample(3).join(", ")}"
               when "Neutral Good"
                 "#{$pc['ngdeity'].sample(3).join(", ")}"
               when "Neutral Evil"
                 "#{$pc['nedeity'].sample(3).join(", ")}"
               when "Chaotic Good"
                 "#{$pc['cgdeity'].sample(3).join(", ")}"
               when "Chaotic Neutral"
                 "#{$pc['cndeity'].sample(3).join(", ")}"
               when "Chaotic Evil"
                 "#{$pc['cedeity'].sample(3).join(", ")}"
               else $pc['deity'].sample(3).join(", ")
               end  
      end

      def generate_weapon(pc_class_case)
        return case pc_class_case
               when "barbarian", "fighter", "paladin", "ranger", "cavalier",\
                    "gunslinger", "magus", "vigilante", "bloodrager", "skald",\
                    "slayer", "swashbuckler", "warpriest", "hunter"
                 $pc['simpmart'].sample
               when "cleric", "sorcerer", "alchemist",\
                    "oracle", "summoner", "witch", "arcanist"
                 $pc['simple'].sample
               when "bard"
                 $pc['bardwep'].sample
               when "inquisitor"
                 $pc['inquisitorwep'].sample
               when "rogue"
                 $pc['roguewep'].sample
               when "brawler"
                 $pc['brawlerwep'].sample
               when "investigator"
                 $pc['investigatorwep'].sample
               when "druid"
                 $pc['druidwep'].sample
               when "monk"
                 $pc['monkwep'].sample
               when "wizard"
                 $pc['wizardwep'].sample
               else
                 $pc['simpmart'].sample
               end
      end

      def romanticrelation
        case rand(1..7)
        when 1..2
            $pc['onelover'].sample
          when 3..6
            $pc['afew'].sample
          when 7..9
            $pc['several'].sample
          when 10..12
            $pc['current'].sample
          when 13..16
            $pc['severalrelations'].sample
          when 17..18
            $pc['experienced'].sample
          when 19..20
            $pc['none'].sample
        end
      end
    end
  end
end

module Bot
  module DiscordCommands
    # Document your command
    # in some YARD comments here!
    module Character
    module_function
      extend Discordrb::Commands::CommandContainer
      $character = YAML.load(File.read('data/character.yaml'))
      $pc = YAML.load(File.read('data/pc.yaml'))
      $gender = ["He", "She"].sample
      $pronoun =
      case $gender
      when "He"
        then "His"
      when "She"
        then "Her"
      else "their"
      end

      $pcclass = $pc['class'].sample
      $pclasscase = $pcclass["pcclass"]
      $icon = $pcclass['icon']
      $race = "#{$pc['race'].sample.capitalize}"

      $align =
      case $pclasscase
        when "paladin"
          then "Lawful Good"
        else $pc['align'].sample
      end

      $deity =
      case $align
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
      $weapon =
      case $pclasscase
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

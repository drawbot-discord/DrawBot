module Bot
  module DiscordCommands
    # Document your command
    # in some YARD comments here!
    module Animal
      extend Discordrb::Commands::CommandContainer
      module_function
      $randimal = YAML.load(File.read('data/randimal.yaml'))
      def avian
        hash = {}
        hash["species"] = "avian"
        hash["size"] = $randimal['size'].sample
        hash["rarity"] = $randimal['rarity'].sample
        hash["knowledge"] = $randimal['knowledge'].sample
        hash["colour"] = "#{$randimal['feathercolourdesc'].sample} #{$randimal['feathercolour'].sample}"
        hash["skindesc"] = $randimal['avianskin'].sample
        hash["skinlength"] = $randimal['avianskinlength'].sample
        hash["ubodypart"] = "#{$randimal['ubodypartavian'].sample} #{$randimal['wings'].sample}"
        hash["lbodypart"] = "#{$randimal['lbodypartavian'].sample} "\
                            "#{$randimal['leggrade'].sample} legs ending in #{$randimal['avianfeet'].sample}"
        hash["tail"] = "It has a #{$randimal['aviantail'].sample} tail that is #{$randimal['feathercolourdesc'].sample} #{$randimal['feathercolour'].sample} and #{$randimal['aviantailsize'].sample} its body"
        hash["mating"] = "It attracts a #{$randimal['aviantypeofmate'].sample} mate by #{$randimal['avianmatingbehaviour'].sample}. It stays with it's mate #{$randimal['avianrelationshiplength'].sample}. It takes the babies #{$randimal['avianfledgetime'].sample} to develop enough to survive on their own."
        hash["lifespan"] = $randimal['avianlifespan'].sample
        hash["teritorial"] = "bird is #{$randimal['avianteritorial'].sample} and it marks it's territory by #{$randimal['avianteritorialclaim'].sample}"
        hash["nose"] = "It has a #{$randimal['aviannoselength'].sample} #{$randimal['aviannoseshape'].sample} beak."
        hash["eyes"] = "Above the beak rests eyes that are #{$randimal['avianeyeshape'].sample} and #{$randimal['avianeyesize'].sample} in size and grant #{$randimal['aviansightquality'].sample} sight."
        hash["ears"] #no ears for birds
        animal(hash)
      end

      def animal(info)
       "Your animal is a #{info["knowledge"]} and #{info["rarity"]} #{info["species"]} that is #{info["size"]} in size.\n"\
       "It's covered in #{info["skinlength"]} #{info["colour"]} #{info["skindesc"]} and has #{info["ubodypart"]} and #{info["lbodypart"]}. #{info["tail"]}. #{info["nose"]} #{info["eyes"]} #{info["ears"]} \n"\
       "#{info["mating"]} The typical lifespan is #{info["lifespan"]}. The #{info["teritorial"]}"
      end

      command(:randimal) do |event|
        animal =
          case rand(3..3)
            when 1
              mammal
            when 2
              fish
            when 3
              avian
            when 4
              reptile
            when 5
              amphibian
          end
          event.channel.send_embed do |e|
          e.title = "Fantasy Animal Generator"
          e.description = animal
          end

      end
    end
  end
end

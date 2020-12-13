module Bot
  module DiscordCommands
    # Document your command
    # in some YARD comments here!
    module TestCommands
      module_function
      extend Discordrb::Commands::CommandContainer
      $pcname = YAML.load(File.read('data/pcname.yaml'))

      def comma(n)
        n.to_s.reverse.gsub(/...(?=.)/,'\&,').reverse
      end

      def count
        ["Aasimar       #{comma($aasimarcount)}",
         "Dwarf           #{comma($dwarfcount)}",
         "Half-Elf         #{comma($halfelfcount)}",
         "Elf                  #{comma($elfcount)}",
         "Half-orc        #{comma($halforccount)}",
         "Kobold          #{comma($koboldcount)}",
         "Gnome          #{comma($gnomecount)}",
         "Kitsune         #{comma($kitsunecount)}",
         "Drow             #{comma($drowcount)}",
         "Fairy              #{comma($fairycount)}"].join("\n")
      end
      $aasimarcount = ($pcname['aasimarmalenames1'].count * $pcname['aasimarmalenames2'].count)\
        + $pcname['aasimarfemalenames1'].count + $pcname['aasimarfemalenames2'].count

      def aasimarm
        $pcname['aasimarmalenames1'].sample + $pcname['aasimarmalenames2'].sample
      end

      def aasimarf
        $pcname['aasimarfemalenames1'].sample + $pcname['aasimarfemalenames2'].sample
      end

      $dwarfcount = ($pcname['dwarfmalename1'].count * $pcname['dwarfmalesuffix2'].count)\
        + ($pcname['dwarfhousename1'].count + $pcname['dwarfhousename2'].count)\
        + ($pcname['dwarfmalename1'].count + $pcname['dwarffemalesuffix'].count)

      def dwarfm
        "#{$pcname['dwarfmalename1'].sample + $pcname['dwarfmalesuffix2'].sample}"\
          " #{$pcname['dwarfhousename1'].sample}-#{$pcname['dwarfhousename2'].sample}"
      end

      def dwarff
        "#{$pcname['dwarfmalename1'].sample + $pcname['dwarffemalesuffix'].sample}"\
          " #{$pcname['dwarfhousename1'].sample}-#{$pcname['dwarfhousename2'].sample}"
      end

      $halfelfcount = ($pcname['halfelfmname1'].count * $pcname['halfelfmname2'].count)\
        + ($pcname['halfelfmname1'].count * $pcname['halfelfmname2'].count \
           * $pcname['halfelfmname2'].count) + ($pcname['halfelffname1'].count \
                                                * $pcname['halfelffname2'].count ) + ($pcname['halfelffname1'].count \
                                                                                      * $pcname['halfelffname2'].count * $pcname['halfelffname2'].count)
      def halfelfm
        case rand(1..2)
        when 1
          $pcname['halfelfmname1'].sample + \
            $pcname['halfelfmname2'].sample
        when 2
          "#{$pcname['halfelfmname1'].sample + \
            $pcname['halfelfmname2'].sample}"\
            "'#{$pcname['halfelfmname2'].sample}"
        end
      end

      def halfelff
        case rand(1..2)
        when 1
          $pcname['halfelffname1'].sample + \
            $pcname['halfelffname2'].sample
        when 2
          "#{$pcname['halfelffname1'].sample + \
            $pcname['halfelffname2'].sample}"\
            "'#{$pcname['halfelffname2'].sample}"
        end
      end

      $elfcount = ($pcname['elffemalename1'].count * $pcname['elffemalename2'].count)\
        + ($pcname['elffemalename1'].count * $pcname['elffemalename2'].count\
           * $pcname['elffemalename2'].count) + ($pcname['elfmalename1'].count \
                                                 * $pcname['elfmalename2'].count + $pcname['elffemalename1'].count \
                                                 * $pcname['elffemalename2'].count * $pcname['elffemalename2'].count)

      def elff
        case rand(1..2)
        when 1
          $pcname['elffemalename1'].sample + \
            $pcname['elffemalename2'].sample
        when 2
          "#{$pcname['elffemalename1'].sample + \
            $pcname['elffemalename2'].sample}"\
            "'#{$pcname['elffemalename2'].sample}"
        end
      end

      def elfm
        case rand(1..2)
        when 1
          $pcname['elfmalename1'].sample + \
            $pcname['elfmalename2'].sample
        when 2
          "#{$pcname['elfmalename1'].sample + \
            $pcname['elfmalename2'].sample}"\
            "'#{$pcname['elfmalename2'].sample}"
        end
      end

      $halforccount = ($pcname['malehalforcname1'].count\
                       * $pcname['malehalforcname2'].count\
                       + $pcname['malehalforcname1'].count\
                       * $pcname['malehalforcname2'].count\
                       * $pcname['malehalforcname2'].count)\
      + ($pcname['femalehalforcnames1'].count\
         * $pcname['femalehalforcnames2'].count\
         + $pcname['malehalforcname1'].count\
         * $pcname['malehalforcname2'].count\
         * $pcname['malehalforcname2'].count)

      def halforcm
        case rand(1..2)
        when 1
          $pcname['malehalforcname1'].sample + \
            $pcname['malehalforcname2'].sample
        when 2
          "#{$pcname['malehalforcname1'].sample + \
            $pcname['malehalforcname2'].sample}"\
            "'#{$pcname['malehalforcname2'].sample}"
        end
      end

      def halforcf
        case rand(1..2)
        when 1
          $pcname['femalehalforcnames1'].sample + \
            $pcname['femalehalforcnames2'].sample
        when 2
          "#{$pcname['malehalforcname1'].sample + \
            $pcname['malehalforcname2'].sample}"\
            "'#{$pcname['malehalforcname2'].sample}"
        end
      end

      $koboldcount = ($pcname['malekbldname1'].count\
                      * $pcname['malekbldname2'].count\
                      + $pcname['kbldclanname1'].count\
                      * $pcname['kbldclanname2'].count)\
      * ($pcname['femaleklbldnames1'].count\
         + $pcname['femalekbldnames2'].count\
         + $pcname['kbldclanname1'].count\
         * $pcname['kbldclanname2'].count)

      def koboldm
        "#{$pcname['malekbldname1'].sample + $pcname['malekbldname2'].sample}"\
          " #{$pcname['kbldclanname1'].sample}-#{$pcname['kbldclanname2'].sample}"
      end

      def koboldf
        "#{$pcname['femaleklbldnames1'].sample + $pcname['femalekbldnames2'].sample}"\
          " #{$pcname['kbldclanname1'].sample}-#{$pcname['kbldclanname2'].sample}"
      end

      $gnomecount = ($pcname['gnomemname1'].count\
                     * $pcname['gnomemname2'].count\
                     + $pcname['gnomeln1'].count\
                     * $pcname['gnomeln2'].count)\
      + ($pcname['gnomefname1'].count\
         * $pcname['gnomefname2'].count\
         + $pcname['gnomeln1'].count\
         * $pcname['gnomeln2'].count)

      def gnomem
        "#{$pcname['gnomemname1'].sample + $pcname['gnomemname2'].sample}"\
          " #{$pcname['gnomeln1'].sample}#{$pcname['gnomeln2'].sample}"
      end

      def gnomef
        "#{$pcname['gnomefname1'].sample + $pcname['gnomefname2'].sample}"\
          " #{$pcname['gnomeln1'].sample}#{$pcname['gnomeln2'].sample}"
      end

      $kitsunecount = ($pcname['kitsunemalename1'].count * $pcname['kitsunemalename2'].count)\
        + ($pcname['kitsunefemalename1'].count * $pcname['kitsunevowel'].count \
           * $pcname['kitsunefemalename2'].count)

      def kitsunef
        $pcname['kitsunefemalename1'].sample + $pcname['kitsunevowel'].sample + $pcname['kitsunefemalename2'].sample
      end

      def kitsunem
        $pcname['kitsunemalename1'].sample + $pcname['kitsunemalename2'].sample
      end

      $drowcount = ($pcname['drowmalename1'].count\
                    * $pcname['drowmalename2'].count\
                    + $pcname['drowmalename1'].count\
                    * $pcname['drowmalename2'].count\
                    * $pcname['drowmalename2'].count)\
      + ($pcname['drowfemalename1'].count\
         * $pcname['drowfemalename2'].count\
         + $pcname['drowfemalename1'].count\
         * $pcname['drowfemalename2'].count\
         * $pcname['drowfemalename2'].count)

      def drowf
        case rand(1..3)
        when 1..2
          "#{$pcname['drowfemalename1'].sample + $pcname['drowfemalename2'].sample}"
        when 3
          "#{$pcname['drowfemalename1'].sample + $pcname['drowfemalename2'].sample}'#{$pcname['drowfemalename2'].sample}"
        end
      end

      def drowm
        case rand(1..3)
        when 1..2
          "#{$pcname['drowmalename1'].sample + $pcname['drowmalename2'].sample}"
        when 3
          "#{$pcname['drowmalename1'].sample + $pcname['drowmalename2'].sample}'#{$pcname['drowmalename2'].sample}"
        end
      end

      $fairycount = ($pcname['fairycons1'].count\
                     * $pcname['fairyvowel'].count\
                     * $pcname['fairycons2'].count\
                     * $pcname['fairylastname'].count)\
      + ($pcname['fairynamem'].count\
         * $pcname['fairylastname'].count)\
      + ($pcname['fairynamef'].count\
         * $pcname['fairylastname'].count)

      def fairym
        case rand(1..3)
        when 1..2
          "#{$pcname['fairycons1'].sample + $pcname['fairyvowel'].sample + $pcname['fairycons2'].sample} #{$pcname['fairylastname'].sample}"
        when 3
          "#{$pcname['fairynamem'].sample} #{$pcname['fairylastname'].sample}"
        end
      end

      def fairyf
        case rand(1..3)
        when 1
          "#{$pcname['fairycons1'].sample + $pcname['fairyvowel'].sample + $pcname['fairycons2'].sample} #{$pcname['fairylastname'].sample}"
        when 2..3
          "#{$pcname['fairynamef'].sample} #{$pcname['fairylastname'].sample}"
        end
      end
    end
  end
end

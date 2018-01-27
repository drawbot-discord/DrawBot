module Bot
  module DiscordCommands
    # Document your command
    # in some YARD comments here!
    module ArtCommands
      extend Discordrb::Commands::CommandContainer
      r, g, b = Array.new(3) { rand(0xff) }
        module_function
      def toRGB(hue, sat, lum)
        temp_1 =
        case
         when lum < 0.0
           lum x (1.0 * sat)
         when lum > 0.0
           (lum + sat) - lum
        end
        temp_2 = (2 * lum) - temp_1.to_f
        h = (hue/360.0)
        temp_r = (h + 0.333)
        temp_r = temp_r + 1 if temp_r < 0
        temp_r = temp_r - 1 if temp_r > 1
        temp_g = h
        temp_b = (h - 0.333)
        temp_b = temp_b + 1 if temp_b < 0
        temp_b = temp_b - 1 if temp_b > 1
      red =
        case
          when 6 * temp_r < 1
            temp_2 + (temp_1 - temp_2) * 6 * temp_r
          when 2 * temp_r < 1
            temp_1
          when 3 * temp_r < 2
            temp_2 + (temp_1 - temp_2) * (0.666 - temp_r * 6)
          else
            temp_2
        end
      green =
          case
            when 6 * temp_g < 1
              temp_2 + (temp_1 - temp_2) * 6 * temp_g
            when 2 * temp_g < 1
              temp_1
            when 3 * temp_g < 2
              temp_2 + (temp_1 - temp_2) * (0.666 - temp_g * 6)
            else
              temp_2
          end
      blue =
          case
            when 6 * temp_b < 1
              temp_2 + (temp_1 - temp_2) * 6 * temp_b
            when 2 * temp_b < 1
              temp_1
            when 3 * temp_b < 2
              temp_2 + (temp_1 - temp_2) * (0.666 - temp_b * 6)
            else
              temp_2
          end
        "#{red.floor.to_s(16)}#{green.floor.to_s(16)}#{blue.floor.to_s(16)}"
      end

      def div(a)
        (a / 255.00)
      end

      min, max = [div(r), div(g), div(b)].minmax
      min = min
      max = max

      def lum(mx,mn)
        num = ((mx + mn)/2)
        (num*100)
      end

      def sat(l, mx, mn)
        if l < 0.50
          s = (mx-mn)/(mx+mn)
        elsif l > 0.5
          s = (mx-mn)/(2.0-(mx+mn))
        elsif mx = mn
          0
        end
      end

      def hue(mx, mn, hR, hG, hB)
        h =
        case mx
          when mn
            0
          when hR
            (hG-hB)/(mx-mn)
          when hG
            2.0 + (hB-hR)/(mx-mn)
          when hB
            4.0 + (hR-hG)/(mx-mn)
        end
        h = (h * 60)
        h += 360 if h < -1
        h
      end

      h = hue(max, min, div(r), div(g), div(b))
      s = sat(lum(max,min), max, min)
      l = lum(max,min)


      def comp_color(h,s,l)
        comp_h = (h + 180) % 360
        "https://www.colorcombos.com/combomaker_image.php?design=squares-outlined.png&output_width=350&colors=#{toRGB(h, s, l)},#{toRGB(comp_h, s, l)}&background_color=6F6F6F.png"
      end

      def split_comp(h,s,l)
        first = (h + 150) % 360
        second = (h + 210) % 360
        "https://www.colorcombos.com/combomaker_image.php?design=squares-outlined.png&output_width=500&colors=#{toRGB(h, s, l)},#{toRGB(first, s, l)},#{toRGB(second, s, l)}&background_color=6F6F6F.png"
      end

      def triadic(h,s,l)
        first = (h + 120) % 360
        second = (h + 240) % 360
        "https://www.colorcombos.com/combomaker_image.php?design=squares-outlined.png&output_width=500&colors=#{toRGB(h, s, l)},#{toRGB(first, s, l)},#{toRGB(second, s, l)}&background_color=6F6F6F.png"
      end

      def tetradic(h,s,l)
        first = (h + 90) % 360
        second = (h + 180) % 360
        third = (h + 270) % 360
        "https://www.colorcombos.com/combomaker_image.php?design=squares-outlined.png&output_width=500&colors=#{toRGB(h, s, l)},#{toRGB(first, s, l)},#{toRGB(second, s, l)},#{toRGB(third, s, l)}&background_color=6F6F6F.png"
      end

      def analagous(h,s,l)
        first = (h + 30) % 360
        second = (h + 60) % 360
        third = (h + 90) % 360
        "https://www.colorcombos.com/combomaker_image.php?design=squares-outlined.png&output_width=500&colors=#{toRGB(h, s, l)},#{toRGB(first, s, l)},#{toRGB(second, s, l)},#{toRGB(third, s, l)}&background_color=6F6F6F.png"
      end

      def randcolor
        a, b, c, d, e, f,
        g, h, i,j ,k ,l,
        m, n, o, p, q, r = Array.new(18) { rand(0xff).to_s(16) }
        "https://www.colorcombos.com/combomaker_image.php?design=squares-outlined.png&output_width=500&colors=#{a+b+c},#{d+e+f},#{g+h+i},#{j+k+l},#{m+n+o},#{p+q+r}&background_color=6F6F6F.png"
      end
    end
  end
end

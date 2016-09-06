module DrawBot
  module Database
    # A Zii - DrawBot's 8ball container
    class Zii < Sequel::Model
      # Logs successful creation
      def after_create
        Discordrb::LOGGER.info "created zii: #{inspect}"
      end
    end
  end
end

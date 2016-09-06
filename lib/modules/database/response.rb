module DrawBot
  module Database
    # A collection of chat reponses based
    # off a certain key.
    class Response < Sequel::Model
      # Log object after succesful creation
      def after_create
        Discordrb::LOGGER.info "created response: #{inspect}"
      end

      # Log object before destruction
      def before_destroy
        Discordrb::LOGGER.info "deleted response: #{inspect}"
      end
    end
  end
end

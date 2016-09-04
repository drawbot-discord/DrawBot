module DrawBot
  module Database
    # A collection of chat reponses based
    # off a certain key.
    class Response < Sequel::Model
      def after_create
        Discordrb::LOGGER.info "created response: #{inspect}"
      end
    end
  end
end

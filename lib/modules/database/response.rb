module DrawBot
  module Database
    class Response < Sequel::Model
      def after_create
        Discordrb::LOGGER.info "created response: #{inspect}"
      end
    end
  end
end

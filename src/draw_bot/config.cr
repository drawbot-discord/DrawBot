require "yaml"

module DrawBot
  class Config
    include YAML::Serializable

    property token : String
    property owner_id : UInt64
    property client_id : UInt64

    def initialize(
      @token : String,
      @owner_id : UInt64,
      @client_id : UInt64
    )
    end
  end
end

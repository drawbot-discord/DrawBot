require "yaml"

module DrawBot
  class Config
    include YAML::Serializable

    property token : String
    property owner_id : UInt64
    property client_id : UInt64
    property suggestions_channel : UInt64
    property support_server_invite : String

    def initialize(
      @token : String,
      @owner_id : UInt64,
      @client_id : UInt64,
      @suggestions_channel: UInt64,
      @support_server_invite : String
    )
    end
  end
end

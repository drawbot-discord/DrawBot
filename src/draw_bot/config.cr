require "yaml"

module DrawBot
  class Config
    YAML.mapping(
      token: String,
      owner_id: UInt64
    )

    def initialize(@token : String, @owner_id : UInt64)
    end
  end
end

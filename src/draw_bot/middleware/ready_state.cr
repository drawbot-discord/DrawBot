module DrawBot
  # Middleware for tracking "boot-up" progress when connecting
  class ReadyState
    # Array of expected guild IDs from READY
    getter expected_guilds = Set(UInt64).new

    # Set of guild IDs we've received GUILD_CREATE for
    getter loaded_guilds = Set(UInt64).new

    # Time at which guild streaming started
    getter start_time : Time? = nil

    # Whether all guilds have been observed
    def ready?
      expected_guilds == loaded_guilds
    end

    # Amount of time streaming took
    def elapsed_time
      @start_time.try { |value| Time.now - value }
    end

    def call(payload : Discord::Gateway::ReadyPayload, context)
      @start_time = Time.now
      payload.guilds.each do |guild|
        @expected_guilds.add guild.id
      end
      yield
    end

    def call(payload : Discord::Gateway::GuildCreatePayload, context)
      @loaded_guilds.add payload.id
      yield
    end
  end
end

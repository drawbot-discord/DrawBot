module DrawBot
  class ReadyState < Discord::Middleware
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

    def call(context : Discord::Context(Discord::Gateway::ReadyPayload), done)
      @start_time = Time.now
      context.payload.guilds.each do |guild|
        @expected_guilds.add guild.id
      end
      done.call
    end

    def call(context : Discord::Context(Discord::Gateway::GuildCreatePayload), done)
      @loaded_guilds.add context.payload.id
      done.call
    end
  end
end

module DrawBot
  # Cache of loaded guild IDs
  READY_STATE = ReadyState.new

  # READY event handler that counts how many guilds we should
  # expect from GUILD_CREATE streaming
  client.on_ready(READY_STATE) do
    logger.info { "Expecting #{READY_STATE.expected_guilds.size} guilds.." }
  end

  # GUILD_CREATE handler that displays logging as the guilds stream in,
  # (on DEBUG level) as well as elapsed time once the bot is done loading.
  client.on_guild_create(READY_STATE) do |payload|
    if logger.level.debug?
      logger.debug { "Received #{READY_STATE.loaded_guilds.size} / #{READY_STATE.expected_guilds.size} guilds (#{payload.id} #{payload.name})" }
    end

    if READY_STATE.ready?
      logger.info { "Loading complete! #{READY_STATE.loaded_guilds.size} guilds, Elapsed time: #{READY_STATE.elapsed_time}" }
    end
  end
end

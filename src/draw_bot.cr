require "discordcr-middleware"
require "discordcr-middleware/middleware/cached_routes"

module DrawBot
  {% begin %}
    # Bot configuration
    class_property config do
      if ENV["DRAWBOT_ENV"]? == "test"
        Config.new("Bot TOKEN", 0_u64, 0_u64)
      else
        config = Config.from_yaml(File.read("config.yml"))
      end
    end

    # Logger
    class_property logger = Logger.new(STDOUT)

    # Bot client
    class_property client = Discord::Client.new(config.token, logger: logger)

    # Client cache
    class_property cache = Discord::Cache.new(client)
  {% end %}

  # Attach the cache to the client
  client.cache = cache

  # Set logger to debug mode.
  logger.level = :debug
end

# Require other major application components
require "./draw_bot/*"

# Require middleware suite
require "./draw_bot/middleware/*"

# Require event handlers
require "./draw_bot/handlers/*"

require "discordcr-middleware"

module DrawBot
  {% begin %}
    # Bot configuration
    class_property config = Config.from_yaml(File.read("config.yml"))

    # Bot client
    class_property client = Discord::Client.new(config.token)

    # Client cache
    class_property cache = Discord::Cache.new(client)
  {% end %}

  # Attach the cache to the client
  client.cache = cache
end

# Require other major application components
require "./draw_bot/*"

# Require middleware suite
require "./draw_bot/middleware/*"

# Require event handlers
require "./draw_bot/handlers/*"

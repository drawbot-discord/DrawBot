require 'bundler/setup'
require 'discordrb'
require 'yaml'
require 'rest_client'
require 'rufus-scheduler'
require 'nokogiri'
require 'rest-client'
require 'json'
require 'set'
# The main bot module.
module Bot
  # Load non-Discordrb modules
  Dir['src/modules/*.rb'].each { |mod| load mod }

  # Bot configuration
  CONFIG = OpenStruct.new YAML.load_file 'data/config.yaml'

  # Take shard info from command line
  SHARD_ID = ARGV[0].to_i
  TOTAL_SHARDS = ARGV[1].to_i

  puts "Starting shard #{SHARD_ID} of #{TOTAL_SHARDS}"

  # Create the bot.
  # The bot is created as a constant, so that you
  # can access the cache anywhere.
  BOT = Discordrb::Commands::CommandBot.new(client_id: CONFIG.client_id,
                                            token: CONFIG.token,
                                            prefix: CONFIG.prefix,
                                            shard_id: SHARD_ID,
                                            num_shards: TOTAL_SHARDS,
                                            subscription_events: true)

  BOT.gateway.check_heartbeat_acks = false

  # Discord commands
  module DiscordCommands; end
  Dir['src/modules/commands/*.rb'].each { |mod| load mod }
  DiscordCommands.constants.each do |mod|
    BOT.include! DiscordCommands.const_get mod
  end

  # Discord events
  module DiscordEvents; end
  Dir['src/modules/events/*.rb'].each { |mod| load mod }
  DiscordEvents.constants.each do |mod|
    BOT.include! DiscordEvents.const_get mod
  end




  puts 'I think it\'s time to blow this thing.'
  puts 'Get everybody and their stuff together'
  puts 'Okay, three, two, one let\'s jam.'
  puts ' '
  puts ' '
  # Run the bot
  BOT.run
end

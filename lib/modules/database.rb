module DrawBot
  # The bot's SQL database.
  module Database
    # Connect to database
    DB = Sequel.connect('sqlite://data/drawbot.db')

    # Load migrations
    Sequel.extension :migration
    Sequel::Migrator.run(DB, 'lib/modules/database/migrations')

    # Load models
    Dir['lib/modules/database/*.rb'].each { |mod| load mod }
  end
end

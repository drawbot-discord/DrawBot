module DrawBot
  module DiscordCommands
    # Sync legacy bank accounts from the YAML
    module BankSync
      extend Discordrb::Commands::CommandContainer
      command(:bank_sync,
              help_available: false) do |event|
        break unless event.user.id == CONFIG.owner
        users = YAML.load_file('db.yaml')['users']
        users.each do |id, data|
          user_sql = Database::User.find(discord_id: id)
          user_sql ||= Database::User.create(discord_id: id,
                                             discord_name: data['name'])
          next unless user_sql.bank.nil?
          Database::Bank.create(user: user_sql,
                                stipend: CONFIG.stipend,
                                hearts: data['hearts'],
                                salt: data['salt'])
        end
        '`done`'
      end
    end
  end
end

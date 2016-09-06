Sequel.migration do
  up do
    create_table(:servers) do
      primary_key :id
      DateTime :timestamp
      Integer :discord_id, unique: true, null: false
      Integer :owner_id, null: false
      String :discord_name, null: false
    end
  end

  down do
    drop_table(:servers)
  end
end

Sequel.migration do
  up do
    create_table(:users) do
      primary_key :id
      DateTime :timestamp
      Integer :discord_id, unique: true, null: false
      String :discord_name, null: false
    end
  end

  down do
    drop_table(:users)
  end
end

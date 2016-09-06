Sequel.migration do
  up do
    create_table(:responses) do
      primary_key :id
      String :key
      String :response, null: false
    end
  end

  down do
    drop_table(:responses)
  end
end

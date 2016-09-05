Sequel.migration do
  up do
    create_table(:ziis) do
      primary_key :id
      String :fortune
      String :image_url
    end
  end

  down do
    drop_table(:ziis)
  end
end

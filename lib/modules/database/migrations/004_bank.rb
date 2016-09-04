Sequel.migration do
  up do
    create_table(:banks) do
      primary_key :id
      foreign_key :user_id, :users, unique: true, null: false, on_delete: :cascade
      Integer :stipend, null: false, default: 0
      Integer :hearts, null: false, default: 0
      Integer :salt, null: false, default: 0
    end
  end

  down do
    drop_table(:banks)
  end
end

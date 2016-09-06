Sequel.migration do
  up do
    create_table(:transactions) do
      primary_key :id
      DateTime :timestamp
      foreign_key :bank_id, :banks, null: false, on_delete: :cascade
      foreign_key :user_id, :users, null: false, on_delete: :cascade
      String :kind, null: false
      Integer :amount, null: false
    end
  end

  down do
    drop_table(:transactions)
  end
end

class CreateAllocations < ActiveRecord::Migration
  def change
    create_table :allocations do |t|
      t.integer :amount
      t.references :budget
      t.references :transaction

      t.timestamps
    end
    add_index :allocations, :budget_id
    add_index :allocations, :transaction_id
  end
end

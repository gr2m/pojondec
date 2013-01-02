class DefaultValues < ActiveRecord::Migration
  def up
    change_column :allocations, :budget_id, :integer, :null => false
    change_column :allocations, :transaction_id, :integer, :null => false

    change_column :budgets, :name, :string, :null => false, :default => ""

    change_column :transactions, :account_id, :integer, :null => false
    change_column :transactions, :amount, :integer, :null => false, :default => 0
    change_column :transactions, :is_new, :boolean, :null => false, :default => true

    change_column :uploads, :filename, :string, :null => false
    change_column :uploads, :checksum, :string, :null => false
    change_column :uploads, :account_id, :integer, :null => false
    change_column :uploads, :is_processed, :boolean, :null => false, :default => false
  end

  def down
  end
end

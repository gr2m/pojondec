class AddProcessorToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :processor, :string
  end
end

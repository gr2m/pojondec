class AddNumberToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :number, :string
  end
end
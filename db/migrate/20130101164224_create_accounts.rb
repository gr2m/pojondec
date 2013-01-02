class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :currency
      t.text :details

      t.timestamps
    end
  end
end

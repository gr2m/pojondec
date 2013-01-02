class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :account
      t.datetime :booking_date
      t.integer :amount
      t.text :details
      t.boolean :is_new

      t.timestamps
    end
    add_index :transactions, :account_id
  end
end

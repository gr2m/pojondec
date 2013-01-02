class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :filename
      t.integer :size
      t.text :contents
      t.references :account

      t.timestamps
    end
    add_index :uploads, :account_id
  end
end

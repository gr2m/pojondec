class AddUploadIdToTransactions < ActiveRecord::Migration
  def self.up
    change_table :transactions do |t|
      t.references :upload
    end
  end
  def self.down
    remove_column :transactions, :upload_id
  end
end

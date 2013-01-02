class AddRemoteIdToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :remote_id, :integer
  end
end

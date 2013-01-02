class RemoveSizeFromFile < ActiveRecord::Migration
  def change
    remove_column :accounts, :size
  end
end

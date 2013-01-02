class AddIsProcessedToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :is_processed, :boolean
  end
end

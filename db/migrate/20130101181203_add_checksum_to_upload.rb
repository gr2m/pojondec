class AddChecksumToUpload < ActiveRecord::Migration
  def change
    add_column :uploads, :checksum, :string
  end
end

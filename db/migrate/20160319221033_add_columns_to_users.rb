class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pb_device_iden, :string
    add_column :users, :pb_access_token, :string
    add_column :users, :pb_device_type, :string
  end
end

class RenameColumnsForUsers < ActiveRecord::Migration
  def change
    rename_column :users, :oath_expires_at, :oauth_expires_at
    rename_column :users, :oath_token, :oauth_token
  end
end

class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.float :latitude
      t.float :longitude
      t.string :provider
      t.string :uid
      t.string :oath_token
      t.datetime :oath_expires_at
      t.integer :phone_number

      t.timestamps null: false
    end
  end
end

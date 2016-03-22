class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.boolean :first
      t.boolean :second
      t.boolean :third
      t.integer :user_id
      t.datetime :upcoming_date

      t.timestamps null: false
    end
  end
end

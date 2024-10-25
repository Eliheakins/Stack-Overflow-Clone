class CreateNotifications < ActiveRecord::Migration[7.2]
  def change
    create_table :notifications do |t|
      t.string :message
      t.boolean :read
      t.timestamps
    end
  end
end

class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :comment, index: true
      t.boolean :read, default: false

      t.timestamps null: false
    end
    add_foreign_key :notifications, :comments
  end
end

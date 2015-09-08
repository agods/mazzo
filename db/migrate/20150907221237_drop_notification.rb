class DropNotification < ActiveRecord::Migration
  def change
  	drop_table :notifications
  end
end

class AddStatusToDesignApplications < ActiveRecord::Migration
  def change
    add_column :design_applications, :status, :boolean, null: false, default: true
  end
end

class AddApprovedtoDesignApplications < ActiveRecord::Migration
  def change
  	add_column :design_applications, :approved, :boolean
  end
end

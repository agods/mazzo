class AddNotesToDesignApplications < ActiveRecord::Migration
  def change
    add_column :design_applications, :note, :text
  end
end

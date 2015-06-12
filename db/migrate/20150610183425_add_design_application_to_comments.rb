class AddDesignApplicationToComments < ActiveRecord::Migration
  def change
    add_column :comments, :design_application_id, :reference
  end
end

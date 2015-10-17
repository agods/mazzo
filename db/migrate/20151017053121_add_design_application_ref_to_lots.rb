class AddDesignApplicationRefToLots < ActiveRecord::Migration
  def change
    add_reference :lots, :design_application, index: true
    add_foreign_key :lots, :design_applications
  end
end

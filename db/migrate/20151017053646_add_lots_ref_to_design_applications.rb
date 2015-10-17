class AddLotsRefToDesignApplications < ActiveRecord::Migration
  def change
    add_reference :design_applications, :lot, index: true
    add_foreign_key :design_applications, :lots
  end
end

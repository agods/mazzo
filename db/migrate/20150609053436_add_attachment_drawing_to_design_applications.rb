class AddAttachmentDrawingToDesignApplications < ActiveRecord::Migration
  def self.up
    change_table :design_applications do |t|
      t.attachment :drawing
    end
  end

  def self.down
    remove_attachment :design_applications, :drawing
  end
end

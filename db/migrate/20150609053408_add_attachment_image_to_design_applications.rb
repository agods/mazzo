class AddAttachmentImageToDesignApplications < ActiveRecord::Migration
  def self.up
    change_table :design_applications do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :design_applications, :image
  end
end

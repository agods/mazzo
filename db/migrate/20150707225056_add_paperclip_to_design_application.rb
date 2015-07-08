class AddPaperclipToDesignApplication < ActiveRecord::Migration
  def change
  	add_attachment :design_applications, :image_two
  	add_attachment :design_applications, :image_three
  	add_attachment :design_applications, :image_four
  	add_attachment :design_applications, :image_five
  end
end

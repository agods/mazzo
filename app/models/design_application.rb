class DesignApplication < ActiveRecord::Base
	has_many :comments
	has_attached_file :image
	has_attached_file :drawing
	validates_attachment :image, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }
	validates_attachment_content_type :drawing, content_type: ['image/jpeg', 'image/png', 'image/gif', 'application/pdf']
end

class DesignApplication < ActiveRecord::Base
	has_many :comments
	has_many :neighbors
	accepts_nested_attributes_for :neighbors, :reject_if => :all_blank, :allow_destroy => true
	has_attached_file :image
	has_attached_file :image_two
	has_attached_file :image_three
	has_attached_file :image_four
	has_attached_file :image_five
	has_attached_file :drawing
	validates_attachment :image, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }
	validates_attachment :image_two, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }
	validates_attachment :image_three, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }
	validates_attachment :image_four, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }
	validates_attachment :image_five, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }
	validates_attachment_content_type :drawing, content_type: ['image/jpeg', 'image/png', 'image/gif', 'application/pdf']
	validates :name, :tag_list, :note, presence: true
  	#validates :start_date,
  	#	date: { after: Proc.new { Time.now }}
  	#validates :end_date,
  	#	date: { after: :start_date }
	acts_as_votable
	acts_as_taggable
end

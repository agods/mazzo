class DesignApplication < ActiveRecord::Base
	has_many :comments
	has_many :neighbors
	accepts_nested_attributes_for :neighbors, :reject_if => :all_blank, :allow_destroy => true
	has_attached_file :image
	has_attached_file :drawing
	validates_attachment :image, :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }
	validates_attachment_content_type :drawing, content_type: ['image/jpeg', 'image/png', 'image/gif', 'application/pdf']
	validates :name, :address, :email, :phone, :work_address, :description,
  		 :start_date, :end_date, presence: true
  	validates :start_date,
  		date: { after: Proc.new { Time.now }}
  	validates :end_date,
  		date: { after: :start_date }
	acts_as_votable
end

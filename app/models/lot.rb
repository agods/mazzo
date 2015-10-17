class Lot < ActiveRecord::Base
	has_many :design_applications
	accepts_nested_attributes_for :design_applications, :reject_if => :all_blank, :allow_destroy => true
	validates :name, presence: true
end

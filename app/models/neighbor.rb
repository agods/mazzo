class Neighbor < ActiveRecord::Base
  belongs_to :design_application
  validates :name, :address, :phone, :email, presence: true
end

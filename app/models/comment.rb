class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :design_application
  has_many :notification, dependent: :destroy
  validates :user_id, presence: true
  validates :body, presence: true
  acts_as_tree order: 'created_at DESC'
end

class RootPost < ApplicationRecord
  validates :user_id, presence: true
  
  mount_uploader :picture, PictureUploader

  belongs_to :user
  has_many :child_posts
end

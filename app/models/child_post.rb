class ChildPost < ApplicationRecord
  validates :user_id, presence: true

  mount_uploader :picture, PictureUploader
  
  belongs_to :root_post
  belongs_to :user
end

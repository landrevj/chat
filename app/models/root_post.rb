class RootPost < ApplicationRecord
  mount_uploader :picture, PictureUploader
  has_many :child_posts
end

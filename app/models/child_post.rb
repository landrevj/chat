class ChildPost < ApplicationRecord
  mount_uploader :picture, PictureUploader
  belongs_to :root_post
end

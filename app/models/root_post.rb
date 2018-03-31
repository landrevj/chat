class RootPost < ApplicationRecord
  validates :user_id, presence: true
  validates :body, presence: true, length: { maximum: 100, too_long: "cannot be longer than %{count} characters" }

  mount_uploader :picture, PictureUploader

  belongs_to :user
  has_many :child_posts
end

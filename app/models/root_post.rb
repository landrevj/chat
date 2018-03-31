class RootPost < ApplicationRecord
  validates :user_id, presence: true
  validates :body, length: { maximum: 100, too_long: "cannot be longer than %{count} characters" }
  validates :body, presence: true, unless: proc { |r| r.picture.present? }

  mount_uploader :picture, PictureUploader

  belongs_to :user
  has_many :child_posts
end

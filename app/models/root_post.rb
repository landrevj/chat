class RootPost < ApplicationRecord
  validates :user_id, presence: true
  validates :subject, length: { maximum: 50, too_long: "cannot be longer than %{count} characters" }
  validates :body, length: { maximum: 2000, too_long: "cannot be longer than %{count} characters" }
  validates :body, presence: true, unless: proc { |r| r.picture.present? }

  mount_uploader :picture, PictureUploader

  belongs_to :user
  has_many :child_posts

  def file_count
    sum = 0
    self.child_posts.each do |c|
      sum += 1 if c.picture.present?
    end
    sum += 1 if self.picture.present?
    sum
  end
end

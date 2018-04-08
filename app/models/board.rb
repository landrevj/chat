class Board < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 25, too_long: "cannot be longer than %{count} characters" }
  validates :abbreviation, presence: true, uniqueness: true, length: { maximum: 4, too_long: "cannot be longer than %{count} characters" }

  has_many :root_posts, dependent: :destroy

  def to_param
    abbreviation
  end
end

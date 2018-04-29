class Message < ApplicationRecord
  validates :body, length: { maximum: 1000, too_long: "cannot be longer than %{count} characters" }
  belongs_to :room
  belongs_to :user
end

class Message < ApplicationRecord
  validates :body, length: { minimum: 1,
                             maximum: 1000,
                             too_short: "cannot be empty",
                             too_long: "cannot be longer than %{count} characters" }
  belongs_to :room
  belongs_to :user
end

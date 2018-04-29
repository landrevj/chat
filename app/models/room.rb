class Room < ApplicationRecord
  # validates :user_id, presence: true
  has_many :room_users, dependent: :destroy
  has_many :users, through: :room_users, source: :user
  has_many :messages, dependent: :destroy
end

class Room < ApplicationRecord
  validates :user_id, presence: true
  belongs_to :user

  has_many :room_users, dependent: :destroy
  has_many :users, through: :room_users
  has_many :messages, dependent: :destroy
end

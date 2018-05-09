class Room < ApplicationRecord
  validates :user_id, presence: true
  validates :name, presence: true,
                   uniqueness: true,
                   length: { minimum: 1, maximum: 25, too_short: "cannot be blank", too_long: "cannot be longer than %{count} characters" }
           
  before_save :format_fields

  belongs_to :user

  has_many :room_users, dependent: :destroy
  has_many :users, through: :room_users
  has_many :messages, dependent: :destroy

  private
    def format_fields
      self.name = self.name.parameterize.underscore
    end
end

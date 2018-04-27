class User < ApplicationRecord
  include Storext.model
  # "settings" matches what we named the database column
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  validates :user_name, presence: true, length: { minimum: 4, maximum: 16 }

  has_many :root_posts, dependent: :destroy
  has_many :child_posts, dependent: :destroy

  store_attributes :preferences do
    timezone     String, default: 'UTC'
    thread_theme String, default: 'card_small'
    anonymous    Boolean, default: true
  end
end

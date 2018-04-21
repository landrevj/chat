class ChildPost < ApplicationRecord
  include Storext.model
  
  validates :user_id, presence: true
  validates :body, length: { maximum: 2000, too_long: "cannot be longer than %{count} characters" }
  validates :body, presence: true, unless: proc { |c| c.picture.present? }

  mount_uploader :picture, PictureUploader

  belongs_to :root_post
  belongs_to :user

  store_attributes :properties do
    root_reply_ids Array[Integer], default: []
    child_reply_ids Array[Integer], default: []
  end
end

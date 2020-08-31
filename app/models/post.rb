class Post < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader
  validates :user_id,     presence: true
  validates :description, presence: true
  validates :image,       presence: true
end

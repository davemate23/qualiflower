class Institute < ApplicationRecord
	has_many :locations
	has_many :courses

	validates :ukprn, uniqueness: true

	mount_uploader :image, ImageUploader
	has_many :comments, as: :commentable, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy

end

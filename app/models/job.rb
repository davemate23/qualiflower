class Job < ApplicationRecord
	mount_uploader :image, ImageUploader
	has_many :courses
	has_many :comments, as: :commentable, dependent: :destroy
end

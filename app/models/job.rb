class Job < ApplicationRecord
	mount_uploader :image, ImageUploader
	has_many :courses
	acts_as_commentable
end

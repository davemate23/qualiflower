class Institute < ApplicationRecord
	has_many :locations
	has_many :courses

	validates :ukprn, uniqueness: true

	mount_uploader :image, ImageUploader
	acts_as_commentable	
	searchkick

end

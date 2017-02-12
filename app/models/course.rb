class Course < ApplicationRecord
	belongs_to :institute, optional: true
	has_many :accreditations

	validates :kiscourseid, uniqueness: true

	mount_uploader :image, ImageUploader
end

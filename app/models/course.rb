class Course < ApplicationRecord
	belongs_to :institute, optional: true
	has_many :accreditations

	validates :kiscourseid, uniqueness: true
end

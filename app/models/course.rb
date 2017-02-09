class Course < ApplicationRecord
	belongs_to :institute, optional: true

	validates :kiscourseid, uniqueness: true
end

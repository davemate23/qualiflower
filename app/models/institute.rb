class Institute < ApplicationRecord
	has_many :locations
	has_many :courses

	validates :ukprn, uniqueness: true

	

end

class AccreditationByCourse < ApplicationRecord
	belongs_to :course, optional: true
end

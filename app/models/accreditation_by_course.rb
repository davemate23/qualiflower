class AccreditationByCourse < ApplicationRecord
	belongs_to :course_stat, optional: true
end

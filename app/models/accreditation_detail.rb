class AccreditationDetail < ApplicationRecord
	belongs_to :course, optional: true
end

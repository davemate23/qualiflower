class JobType < ApplicationRecord
	belongs_to :course, optional: true
end

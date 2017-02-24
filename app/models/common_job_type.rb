class CommonJobType < ApplicationRecord
	belongs_to :course, optional: true
end

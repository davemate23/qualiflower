class Accreditation < ApplicationRecord
	has_many :accreditation_details, dependent: :destroy
	belongs_to :course, optional: true
end

class Course < ApplicationRecord
	belongs_to :institute, optional: true
	belongs_to :location, optional: true
	has_many :accreditations
	has_many :qualifications
	has_many :course_stages
	has_many :salaries
	has_many :accreditation_by_courses
	has_many :accreditation_details
	has_many :common_job_types
	has_many :continuations
	has_many :degree_classes
	has_many :employments
	has_many :entries
	has_many :jobs
	has_many :job_types
	has_many :nhs_nss
	has_many :nss
	has_many :subject_entities
	has_many :tariffs
	has_many :ucas

	validates :kiscourseid, uniqueness: true

	mount_uploader :image, ImageUploader
end

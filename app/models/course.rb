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
	has_many :comments, as: :commentable, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy

	# validates :kiscourseid, uniqueness: true


  def self.search_results(search)
    if search
      courses =  Course.search { fulltext "#{search}" }
    else
      courses =  Course.order('created_at desc')
    end
  end

  searchable do
    text :description
    text :title
    string :description
    string :title
    string :duration
    string :mode_of_study
    string :string
    text :contact_details
    text :entry_requirements
    text :future_careers

  end

end

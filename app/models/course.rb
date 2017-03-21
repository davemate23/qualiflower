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

  def self.get_course_stats

    Institute.all.each do |each_institute|
      api=Unistats.new('7KGKHK8R5HFY8L6FL4Z4')


      $i = 0
      institutions=[]
      begin
        # puts("Inside the loop i = #$i" )
        # api=Unistats.new('7KGKHK8R5HFY8L6FL4Z4')
        courses << api.courses(each_institute.ukprn, $i)
        p $i
        $i +=1;
      end until api.institutions($i).count < 25
      courses && courses.flatten.each do |each_ele|
        institute = Institute.find_or_create_by(:name=>each_ele["Name"])
        institute.suurl=each_ele["StudentUnionUrl"]
        institute.ukprn=each_ele["UKPRN"]
        institute.pubukprn=each_ele["PUBUKPRN"]
        institute.country=each_ele["Country"]
        institute.pubukprncountry=each_ele["PUBUKPRNCountry"]
        institute.tefmark=each_ele["TEFMarker"]
        institute.q24pop=each_ele["NSSQuestion24Population"]
        institute.q24=each_ele["NSSQuestion24"]
        institute.q24resp_rate=each_ele["NSSQuestion24ResponseRate"]
        institute.save

      end




    end

  end


end

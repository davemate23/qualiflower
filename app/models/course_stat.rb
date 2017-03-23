class CourseStat < ApplicationRecord

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
  belongs_to :course

  validates :kiscourseid, uniqueness: true


  mount_uploader :image, ImageUploader



  def self.get_course_stats

    Institute.all.each do |each_institute|
      api=Unistats.new('7KGKHK8R5HFY8L6FL4Z4')

      $i = 0
      institutions=[]
      courses=[]
      begin
        # puts("Inside the loop i = #$i" )
        # api=Unistats.new('7KGKHK8R5HFY8L6FL4Z4')
        courses << api.courses(each_institute.ukprn, $i)
        p $i
        $i +=1;
      end
      courses && courses.flatten.each do |each_ele|
        course = api.course(each_ele["ApiUrl"].split('/')[7], each_ele["ApiUrl"].split('/')[9],each_ele["ApiUrl"].split('/')[10])
        institute = Institute.where(:ukprn=>each_ele["ApiUrl"].split('/')[7]).first
        if institute.present?
          # institute.course
          course_stat = institute.course_stats.find_or_create_by(:title=>'name',pubukprn:institute.pubukprn,ukprn:institute.ukprn)
          # course_stat.suurl=each_ele["SupportDetailsUrl"]
          course_stat.title=each_ele["Title"]
          course_stat.engfee=''
          course_stat.pubukprn=institute.pubukprn
          course_stat.ukprn=institute.ukprn
          course_stat.assurl=each_ele["AssessmentMethodsUrl"]
          course_stat.crseurl=each_ele["CoursePageUrl"]
          course_stat.distance=each_ele["DistanceLearning"]
          course_stat.employurl=each_ele["EmploymentDetailsUrl"]
          course_stat.feetbc=each_ele["FeesToBeConfirmed"]
          course_stat.honours=each_ele["Honours"]
          course_stat.foundation=each_ele["FoundationYearAvailable"]
          course_stat.jacs1=each_ele["JACSCodes"]
          course_stat.jacs2=''
          course_stat.jacs3=''
          course_stat.kiscourseid=each_ele["KisCourseId"]
          course_stat.kismode=each_ele["KisMode"]
          course_stat.kistype=each_ele["KISType"]
          course_stat.ldcs1=each_ele["KisAimCode"]
          course_stat.ldcs2=''
          course_stat.ldcs3=''
          course_stat.level=each_ele["StudyLevel"]
          course_stat.locchnge=each_ele["LocationChangesDuringCourse"]
          course_stat.lturl=each_ele["LearningAndTeachingMethodsUrl"]
          course_stat.meanssup=each_ele["MeansTestedSupport"]
          course_stat.nhs=each_ele["NonMeansTestedSupport"]
          course_stat.nifee=each_ele["MaximumFeeForNIDomicile"]
          course_stat.noncreditassess=each_ele["NonCreditAssessment"]
          course_stat.numstage=each_ele["TotalNumberOfStages"]
          course_stat.othsup=''
          course_stat.relatedkis1=each_ele["RelatedKISCourseIds"].to_s[0]
          course_stat.relatedkis2=each_ele["RelatedKISCourseIds"].to_s[1]
          course_stat.relatedkis3=each_ele["RelatedKISCourseIds"].to_s[2]
          course_stat.sandwich=each_ele["SandwichAvailable"]
          course_stat.scotfee=each_ele["MaximumFeeForScotlandDomicile"]
          course_stat.supporturl=each_ele["SupportDetailsUrl"]
          course_stat.ucasprogid=''
          course_stat.ukprnapply=each_ele["ApplicationUKPRN"]
          course_stat.varfee=''
          course_stat.wafee=each_ele["FeeWaiverAvailable"]
          course_stat.waiver=each_ele["FeeVariesByYear"]
          course_stat.welsh=each_ele["PercentAvailableInWelsh"]
          course_stat.yearabroad=each_ele["YearAbroadAvailable"]
          course_stat.kisaim=each_ele["KisAimCode"]
          course_stat.avgwritten=each_ele["AverageInWrittenExams"]
          course_stat.avgscheduled=each_ele["AverageInScheduledLearningAndTeaching"]
          course_stat.save
          p '========================errrrrr=========='
          p course_stat.errors
          p '================enenen================='

        end
      end

    end

  end





end

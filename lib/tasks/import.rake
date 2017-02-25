require 'csv'

namespace :import do

	desc "Import institutions from csv"
	task institutes: :environment do
 		filename1 = File.join(Rails.root, 'app', 'csv', 'UNISTATS_UKPRN_lookup_20160901.csv')
 		filename2 = File.join(Rails.root, 'app', 'csv', 'INSTITUTION.csv')
 		counter = 0

 		CSV.foreach(filename1, headers: true) do |row|
 			
 			institute = Institute.create(ukprn: row["UKPRN"], name: row["NAME"])
 			puts "#{institute.name} - #{institute.errors.full_messages.join(",")}" if institute.errors.any?
 			counter += 1 if institute.persisted?
 		end

 		puts "Imported #{counter} institutes."
 		counter = 0


		CSV.foreach(filename2, headers: true) do |row|

			Institute.where(ukprn: row["UKPRN"]).update_all(pubukprn: row["PUBUKPRN"], country: row["COUNTRY"], pubukprncountry: row["PUBUKPRNCOUNTRY"], tefmark: row["TEFMARKER"], suurl: row["SUURL"], q24: row["Q24"], q24pop: row["Q24POP"], q24resp_rate: row["Q24RESP_RATE"])
      		
 		end

 		puts "Updated the details of #{counter} institutes."
 	end

 	desc "Import institute descriptions from Wikipedia"
 	task institutes: :environment do
 		require 'wikipedia'
 		counter = 0
 		Institute.all.each do |institute|
 			school = institute.name
 			page = Wikipedia.find(school)
 			page = Wikipedia.find(school[3..-1].strip) if page.content.nil? and school[0..2].downcase == 'the'
 			page = Wikipedia.find(school[0..-8].strip) if page.content.nil? and school.end_with? 'Limited'
 			page = Wikipedia.find(school[0..-4].strip) if page.content.nil? and school.end_with? 'Ltd'
 			next if page.content.nil?

 			description = page.summary
 			if page.image_urls.first == "https://upload.wikimedia.org/wikipedia/en/4/4a/Commons-logo.svg" 
 				image = page.image_urls.last
 			else
 				image = page.image_urls.first 				
 			end
 			institute.update!(description: description, remote_image_url: image)
 			puts "#{institute.name} - #{institute.errors.full_messages.join(",")}" if institute.errors.any?
 			counter += 1 if institute.persisted?
 		end
 		puts "Imported the Wikipedia details of #{counter} institutes."
 	end

 	desc "Import locations from csv"
	task institutes: :environment do
 		filename = File.join(Rails.root, 'app', 'csv', 'LOCATION.csv')
 		counter = 0

 		CSV.foreach(filename, headers: true) do |row|
 			location = Location.create(accomurl: row["ACCOMURL"], ukprn: row["UKPRN"], instbeds: row["INSTBEDS"], instlower: row["INSTLOWER"], instupper: row["INSTUPPER"], locid: row["LOCID"], name: row["LOCNAME"], lat: row["LATITUDE"], long: row["LONGITUDE"], locukprn: row["LOCUKPRN"], loccountry: row["LOCCOUNTRY"], privatelower: row["PRIVATELOWER"], privateupper: row["PRIVATEUPPER"], suurl: row["SUURL"])
 			puts "#{location.name} - #{location.errors.full_messages.join(",")}" if location.errors.any?
 			counter += 1 if location.persisted?
 		end
 		puts "Imported #{counter} locations."
 	end

 	desc "Associate locations with institutes"
 	task institutes: :environment do
 		Institute.find_each do |institute|
 			Location.where(ukprn: institute.ukprn).update_all(institute_id: institute.id)
 		end
 	end




	desc "Import courses from csv"
	task courses: :environment do
 		filename = File.join(Rails.root, 'app', 'csv', 'KISCOURSE.csv')
 		counter = 0

 		CSV.foreach(filename, headers: true) do |row|
 			course = Course.create(pubukprn: row["PUBUKPRN"], ukprn: row["UKPRN"], assurl: row["ASSURL"], crseurl: row["CRSEURL"], distance: row["DISTANCE"], employurl: row["EMPLOYURL"], engfee: row["ENGFEE"], feetbc: row["FEETBC"], foundation: row["FOUNDATION"], honours: row["HONOURS"], jacs1: row["JACS1"], jacs2: row["JACS2"], jacs3: row["JACS3"], kiscourseid: row["KISCOURSEID"], kismode: row["KISMODE"], kistype: row["KISTYPE"], ldcs1: row["LDCS1"], ldcs2: row["LDCS2"], ldcs3: row["LDCS3"], level: row["LEVEL"], locchnge: row["LOCCHNGE"], lturl: row["LTURL"], meanssup: row["MEANSSUP"], nhs: row["NHS"], nifee: row["NIFEE"], noncreditassess: row["NONCREDITASSESS"], numstage: row["NUMSTAGE"], othsup: row["OTHSUP"], relatedkis1: row["RELATEDKIS1"], relatedkis2: row["RELATEDKIS2"], relatedkis3: row["RELATEDKIS3"], sandwich: row["SANDWICH"], scotfee: row["SCOTFEE"], supporturl: row["SUPPORTURL"], title: row["TITLE"], ucasprogid: row["UCASPROGID"], ukprnapply: row["UKPRNAPPLY"], varfee: row["VARFEE"], waiver: row["WAIVER"], welsh: row["WELSH"], yearabroad: row["YEARABROAD"], kisaim: row["KISAIMCODE"], avgwritten: row["AVGWRITTEN"], avgcoursework: row["AVGCOURSEWORK"], avgscheduled: row["AVGSCHEDULED"])
 			puts "#{course.title} - #{course.errors.full_messages.join(",")}" if course.errors.any?
 			counter += 1 if course.persisted?
 		end
 		puts "Imported #{counter} courses."
 	end

 	desc "Associate courses with institutes"
 	task courses: :environment do
 		Institute.find_each do |institute|
 			Course.where(ukprn: institute.ukprn).update_all(institute_id: institute.id)
 		end
 	end

 	desc "Associate courses with locations"
 	task courses: :environment do
 		filename = File.join(Rails.root, 'app', 'csv', 'COURSELOCATION.csv')
 		counter = 0

 		CSV.foreach(filename, headers: true) do |row|
 			courselocation = Location.find_by_locid(row['LOCID'])  	
 			courses = Course.where(kiscourseid: row['KISCOURSEID'], kismode: row['KISMODE']).update(location_id: courselocation)
 			courses.each do |course|
 				puts "#{course.first.title} - #{course.errors.full_messages.join(",")}" if course.errors.any?
 				counter += 1 if course.persisted?
 			end
 		end
 		puts "Added locations to #{counter} courses."
 	end

 	desc "Associate qualifications with courses"
 	task courses: :environment do
 		filename = File.join(Rails.root, 'app', 'csv', 'KISAIM.csv')
 		counter = 0

 		CSV.foreach(filename, headers: true) do |row|
 			courses = Course.where(kisaim: row['KISAIMCODE'])  
 			courses.each do |course|
 				Qualification.create(name: row['KISAIMLABEL'], course_id: course.id)
 				puts "#{course.first.title} - #{course.errors.full_messages.join(",")}" if course.errors.any?
 				counter += 1 if course.persisted?
 			end
 		end
 		puts "Added #{counter} course qualifications."
 	end

 	desc "Import continuation details from csv"
	task courses: :environment do
 		filename = File.join(Rails.root, 'app', 'csv', 'CONTINUATION.csv')
 		counter = 0

 		CSV.foreach(filename, headers: true) do |row|
 			continuation = Continuation.create(pubukprn: row["PUBUKPRN"], ukprn: row["UKPRN"], kiscourseid: row["KISCOURSEID"], kismode: row["CONTPOP"], contagg: row["CONTAGG"], contsbj: row["CONTSBJ"], ucont: row["UCONT"], udormant: row["UDORMANT"], ugained: row["UGAINED"], uleft: row["ULEFT"], ulower: row["ULOWER"])
 			course = Course.find_by_kiscourseid(continuation.kiscourseid)
 			puts "#{course.title} - #{continuation.errors.full_messages.join(",")}" if continuation.errors.any?
 			counter += 1 if continuation.persisted?
 		end
 		puts "Imported #{counter} details of course continuation."
 	end

 	desc "Associate continuation details with courses"
 	task courses: :environment do
 		Course.find_each do |course|
 			Continuation.where(kiscourseid: course.kiscourseid).update_all(course_id: course.id)
 		end
 	end

	desc "Import accreditations from csv"
	task accreditations: :environment do
 		filename = File.join(Rails.root, 'app', 'csv', 'ACCREDITATION.csv')
 		counter = 0

 		CSV.foreach(filename, headers: true) do |row|
 			accreditation = Accreditation.create(pubukprn: row["PUBUKPRN"], ukprn: row["UKPRN"], kiscourse: row["KISCOURSE"], acctype: row["ACCTYPE"], kismode: row["KISMODE"], accdepend: row["ACCDEPEND"], accdependurl: row["ACCDEPENDURL"])
 			course = Course.find_by_kiscourseid(accreditation.kiscourse)
 			puts "#{course.title} - #{accreditation.errors.full_messages.join(",")}" if accreditation.errors.any?
 			counter += 1 if accreditation.persisted?
 		end
 		puts "Imported #{counter} accreditations."
 	end


 	desc "Associate accreditations with courses"
 	task accreditations: :environment do
 		Course.find_each do |course|
 			Accreditation.where(kiscourse: course.kiscourseid).update_all(course_id: course.id)
 		end
 	end

 	desc "Import accreditation details from csv"
	task accreditations: :environment do
 		filename = File.join(Rails.root, 'app', 'csv', 'ACCREDITATIONTABLE.csv')
 		counter = 0

 		CSV.foreach(filename, headers: true) do |row|
 			accreditationdetail = AccreditationDetail.create(accurl: row["ACCURL"], acctext: row["ACCTEXT"], acctype: row["ACCTYPE"])
 			puts "#{accreditationdetail.id} - #{accreditationdetail.errors.full_messages.join(",")}" if accreditationdetail.errors.any?
 			counter += 1 if accreditationdetail.persisted?
 		end
 		puts "Imported #{counter} accreditation details."
 	end

 	desc "Associate accreditations details with accreditation"
 	task accreditations: :environment do
 		Accreditation.find_each do |accreditation|
 			AccreditationDetail.where(acctype: accreditation.acctype).update_all(accreditation_id: accreditation.id)
 		end
 	end

 	desc "Import accreditation details by course from csv"
	task accreditations: :environment do
 		filename = File.join(Rails.root, 'app', 'csv', 'AccreditationByHep.csv')
 		counter = 0

 		CSV.foreach(filename, headers: true) do |row|
 			accreditationbycourse = AccreditationByCourse.create(accbodyname: row["AccreditingBodyName"], acctype: row["AccreditionType"], hep: row["HEP"], kiscoursetitle: ["KisCourseTitle"], kiscourseid: ["KiscourseID"])
 			puts "#{accreditationbycourse.id} - #{accreditationbycourse.errors.full_messages.join(",")}" if accreditationbycourse.errors.any?
 			counter += 1 if accreditationbycourse.persisted?
 		end
 		puts "Imported #{counter} course accreditation details."
 	end

 	desc "Associate accreditations details with courses"
 	task accreditations: :environment do
 		Course.find_each do |course|
 			AccreditationByCourse.where(kiscourseid: course.kiscourseid).update_all(course_id: course.id)
 		end
 	end

 	desc "Import job list from csv"
	task jobs: :environment do
 		filename = File.join(Rails.root, 'app', 'csv', 'JOBLIST.csv')
 		counter = 0

 		CSV.foreach(filename, headers: true) do |row|
 			job = Job.create(pubukprn: row["PUBUKPRN"], ukprn: row["UKPRN"], kiscourseid: row["KISCOURSEID"], kismode: row["KISMODE"], comsbj: row["COMSBJ"], title: row["JOB"], perc: row["PERC"], order: row["ORDER"])
 			puts "#{job.title} - #{job.errors.full_messages.join(",")}" if job.errors.any?
 			counter += 1 if job.persisted?
 		end
 		puts "Imported #{counter} jobs."
 	end

 	desc "Associate jobs with courses"
 	task jobs: :environment do
 		Course.find_each do |course|
 			Job.where(kiscourseid: course.kiscourseid).update_all(course_id: course.id)
 		end
 	end

 	desc "Import common job types from csv"
	task jobs: :environment do
 		filename = File.join(Rails.root, 'app', 'csv', 'COMMON.csv')
 		counter = 0

 		CSV.foreach(filename, headers: true) do |row|
 			commonjobtype = CommonJobType.create(pubukprn: row["PUBUKPRN"], ukprn: row["UKPRN"], kiscourseid: row["KISCOURSEID"], kismode: row["KISMODE"], comsbj: row["COMSBJ"], compop: row["COMPOP"], comresp_rate: row["COMRESP_RATE"], comagg: row["COMAGG"])
 			puts "#{commonjobtype.id} - #{commonjobtype.errors.full_messages.join(",")}" if commonjobtype.errors.any?
 			counter += 1 if commonjobtype.persisted?
 		end
 		puts "Imported #{counter} common job types."
 	end

 	desc "Associate common job types with courses"
 	task jobs: :environment do
 		Course.find_each do |course|
 			CommonJobType.where(kiscourseid: course.kiscourseid).update_all(course_id: course.id)
 		end
 	end

 	desc "Import profession types from csv"
	task jobs: :environment do
 		filename = File.join(Rails.root, 'app', 'csv', 'JOBTYPE.csv')
 		counter = 0

 		CSV.foreach(filename, headers: true) do |row|
 			jobtype = JobType.create(pubukprn: row["PUBUKPRN"], ukprn: row["UKPRN"], kiscourseid: row["KISCOURSEID"], kismode: row["KISMODE"], jobpop: row["JOBPOP"], jobresp_rate: row["JOBRESP_RATE"], jobagg: row["JOBAGG"], jobsbj: row["JOBSBJ"], profman: row["PROFMAN"], otherjob: row["OTHERJOB"], unkwn: ["UNKWN"])
 			puts "#{jobtype.id} - #{jobtype.errors.full_messages.join(",")}" if jobtype.errors.any?
 			counter += 1 if jobtype.persisted?
 		end
 		puts "Imported #{counter} profession types."
 	end

 	desc "Associate profession types with courses"
 	task jobs: :environment do
 		Course.find_each do |course|
 			JobType.where(kiscourseid: course.kiscourseid).update_all(course_id: course.id)
 		end
 	end

 	desc "Import salaries from csv"
	task jobs: :environment do
 		filename = File.join(Rails.root, 'app', 'csv', 'SALARY.csv')
 		counter = 0

 		CSV.foreach(filename, headers: true) do |row|
 			salary = Salary.create(pubukprn: row["PUBUKPRN"], ukprn: row["UKPRN"], kiscourseid: row["KISCOURSEID"], kismode: row["KISMODE"], salpop: row["SALPOP"], salresp_rate: row["SALRESP_RATE"], salagg: row["SALAGG"], salsbj: row["SALSBJ"], ldlq: row["LDLQ"], ldmed: row["LDMED"], lduq: ["LDUQ"], lq: row["LQ"], med: row["MED"], uq: ["UQ"], instlq: row["INSTLQ"], instmed: row["INSTMED"], instuq: ["INSTUQ"])
 			puts "#{salary.id} - #{salary.errors.full_messages.join(",")}" if salary.errors.any?
 			counter += 1 if salary.persisted?
 		end
 		puts "Imported #{counter} salaries."
 	end

 	desc "Associate salaries with courses"
 	task jobs: :environment do
 		Course.find_each do |course|
 			Salary.where(kiscourseid: course.kiscourseid).update_all(course_id: course.id)
 		end
 	end

 	desc "Associate salaries with institutes"
 	task jobs: :environment do
 		Institute.find_each do |institute|
 			Salary.where(ukprn: institute.ukprn).update_all(institute_id: institute.id)
 		end
 	end

 	desc "Import course stages from csv"
	task courses: :environment do
 		filename = File.join(Rails.root, 'app', 'csv', 'COURSESTAGE.csv')
 		counter = 0

 		CSV.foreach(filename, headers: true) do |row|
 			course_stage = CourseStage.create(pubukprn: row["PUBUKPRN"], ukprn: row["UKPRN"], kiscourseid: row["KISCOURSEID"], kismode: row["KISMODE"], assact: row["ASSACT"], coursework: row["COURSEWORK"], independent: row["INDEPENDENT"], ltact: row["LTACT"], placement: row["PLACEMENT"], practical: row["PRACTICAL"], scheduled: ["SCHEDULED"], stage: row["STAGE"], written: row["WRITTEN"])
 			course = Course.find_by_kiscourseid(course_stage.kiscourseid)
 			puts "#{course.title} - #{course_stage.errors.full_messages.join(",")}" if course_stage.errors.any?
 			counter += 1 if course_stage.persisted?
 		end
 		puts "Imported #{counter} course stages."
 	end

 	desc "Associate course stages with courses"
 	task courses: :environment do
 		Course.find_each do |course|
 			CourseStage.where(kiscourseid: course.kiscourseid).update_all(course_id: course.id)
 		end
 	end

 	desc "Associate course stages with institutes"
 	task courses: :environment do
 		Institute.find_each do |institute|
 			CourseStage.where(ukprn: institute.ukprn).update_all(institute_id: institute.id)
 		end
 	end

 	desc "Import degree classes from csv"
	task courses: :environment do
 		filename = File.join(Rails.root, 'app', 'csv', 'DEGREECLASS.csv')
 		counter = 0

 		CSV.foreach(filename, headers: true) do |row|
 			degree_class = DegreeClass.create(pubukprn: row["PUBUKPRN"], ukprn: row["UKPRN"], kiscourseid: row["KISCOURSEID"], kismode: row["KISMODE"], degpop: row["DEGPOP"], degagg: row["DEGAGG"], degsbj: row["DEGSBJ"], ufirst: row["UFIRST"], uupper: row["UUPPER"], ulower: row["ULOWER"], uother: ["UOTHER"], uordinary: row["UORDINARY"], udistinction: row["UDISTINCTION"], umerit: row["UMERIT"], upass: row["UPASS"], una: row["UNA"])
 			course = Course.find_by_kiscourseid(degree_class.kiscourseid)
 			puts "#{course.title} - #{degree_class.errors.full_messages.join(",")}" if degree_class.errors.any?
 			counter += 1 if degree_class.persisted?
 		end
 		puts "Imported #{counter} course degree classes."
 	end

 	desc "Associate degree classes with courses"
 	task courses: :environment do
 		Course.find_each do |course|
 			DegreeClass.where(kiscourseid: course.kiscourseid).update_all(course_id: course.id)
 		end
 	end

 	desc "Associate degree classes with institutes"
 	task courses: :environment do
 		Institute.find_each do |institute|
 			DegreeClass.where(ukprn: institute.ukprn).update_all(institute_id: institute.id)
 		end
 	end

 	desc "Import employment from csv"
	task courses: :environment do
 		filename = File.join(Rails.root, 'app', 'csv', 'EMPLOYMENT.csv')
 		counter = 0

 		CSV.foreach(filename, headers: true) do |row|
 			employment = Employment.create(pubukprn: row["PUBUKPRN"], ukprn: row["UKPRN"], kiscourseid: row["KISCOURSEID"], kismode: row["KISMODE"], emppop: row["EMPPOP"], empagg: row["EMPAGG"], empsbj: row["EMPSBJ"], workstudy: row["WORKSTUDY"], study: row["STUDY"], assunemp: row["ASSUNEMP"], both: ["BOTH"], noavail: row["NOAVAIL"], work: row["WORK"])
 			course = Course.find_by_kiscourseid(employment.kiscourseid)
 			puts "#{course.title} - #{employment.errors.full_messages.join(",")}" if employment.errors.any?
 			counter += 1 if employment.persisted?
 		end
 		puts "Imported #{counter} employment rows."
 	end

 	desc "Associate employment with courses"
 	task courses: :environment do
 		Course.find_each do |course|
 			Employment.where(kiscourseid: course.kiscourseid).update_all(course_id: course.id)
 		end
 	end

 	desc "Associate employment with institutes"
 	task courses: :environment do
 		Institute.find_each do |institute|
 			Employment.where(ukprn: institute.ukprn).update_all(institute_id: institute.id)
 		end
 	end


 	desc "Import entry qualifications from csv"
	task courses: :environment do
 		filename = File.join(Rails.root, 'app', 'csv', 'ENTRY.csv')
 		counter = 0

 		CSV.foreach(filename, headers: true) do |row|
 			entry = Entry.create(pubukprn: row["PUBUKPRN"], ukprn: row["UKPRN"], kiscourseid: row["KISCOURSEID"], kismode: row["KISMODE"], entpop: row["ENTPOP"], entagg: row["ENTAGG"], entsbj: row["ENTSBJ"], access: row["ACCESS"], alevel: row["ALEVEL"], bacc: row["BACC"], degree: ["DEGREE"], foundtn: row["FOUNDTN"], noquals: row["NOQUALS"], other: row["OTHER"], otherhe: row["OTHERHE"])
 			course = Course.find_by_kiscourseid(entry.kiscourseid)
 			puts "#{course.title} - #{entry.errors.full_messages.join(",")}" if entry.errors.any?
 			counter += 1 if entry.persisted?
 		end
 		puts "Imported #{counter} entry qualification rows."
 	end

 	desc "Associate entry standards with courses"
 	task courses: :environment do
 		Course.find_each do |course|
 			Entry.where(kiscourseid: course.kiscourseid).update_all(course_id: course.id)
 		end
 	end

 	desc "Associate entry standards with institutes"
 	task courses: :environment do
 		Institute.find_each do |institute|
 			Entry.where(ukprn: institute.ukprn).update_all(institute_id: institute.id)
 		end
 	end

 	desc "Import NHS Stats from csv"
	task courses: :environment do
 		filename = File.join(Rails.root, 'app', 'csv', 'NHSNSS.csv')
 		counter = 0

 		CSV.foreach(filename, headers: true) do |row|
 			nhsnss = NhsNss.create(pubukprn: row["PUBUKPRN"], ukprn: row["UKPRN"], kiscourseid: row["KISCOURSEID"], kismode: row["KISMODE"], nhspop: row["NHSPOP"], nhsagg: row["NHSAGG"], nhssbj: row["NHSSBJ"], nhsq1: row["NHSQ1"], nhsq2: row["NHSQ2"], nhsq3: row["NHSQ3"], nhsq4: ["NHSQ4"], nhsq5: row["NHSQ5"], nhsq6: row["NHSQ6"])
 			course = Course.find_by_kiscourseid(nhsnss.kiscourseid)
 			puts "#{course.title} - #{nhsnss.errors.full_messages.join(",")}" if nhsnss.errors.any?
 			counter += 1 if nhsnss.persisted?
 		end
 		puts "Imported #{counter} NHS stat rows."
 	end

 	desc "Associate NHS Stats with courses"
 	task courses: :environment do
 		Course.find_each do |course|
 			NhsNss.where(kiscourseid: course.kiscourseid).update_all(course_id: course.id)
 		end
 	end

 	desc "Associate NHS stats with institutes"
 	task courses: :environment do
 		Institute.find_each do |institute|
 			NhsNss.where(ukprn: institute.ukprn).update_all(institute_id: institute.id)
 		end
 	end

 	desc "Import NSS stats from csv"
	task courses: :environment do
 		filename = File.join(Rails.root, 'app', 'csv', 'NSS.csv')
 		counter = 0

 		CSV.foreach(filename, headers: true) do |row|
 			nss = Nss.create(pubukprn: row["PUBUKPRN"], ukprn: row["UKPRN"], kiscourseid: row["KISCOURSEID"], kismode: row["KISMODE"], nsspop: row["NSSPOP"], nssagg: row["NSSAGG"], nsssbj: row["NSSSBJ"], q1: row["Q1"], q2: row["Q2"], q3: row["Q3"], q4: ["Q4"], q5: row["Q5"], q6: row["Q6"], q7: row["Q7"], q8: row["Q8"], q9: row["Q9"], q10: row["Q10"], q11: row["Q11"], q12: row["Q12"], q13: row["13"], q14: row["Q14"], q15: row["Q15"], q16: row["Q16"], q17: row["Q17"], q18: row["Q18"], q19: row["Q19"], q20: row["Q20"], q21: row["Q21"], q22: row["Q22"])
 			course = Course.find_by_kiscourseid(nss.kiscourseid)
 			puts "#{course.title} - #{nss.errors.full_messages.join(",")}" if nss.errors.any?
 			counter += 1 if nss.persisted?
 		end
 		puts "Imported #{counter} NSS stat rows."
 	end

 	desc "Associate NSS stats with courses"
 	task courses: :environment do
 		Course.find_each do |course|
 			Nss.where(kiscourseid: course.kiscourseid).update_all(course_id: course.id)
 		end
 	end

 	desc "Associate NSS stats with institutes"
 	task courses: :environment do
 		Institute.find_each do |institute|
 			Nss.where(ukprn: institute.ukprn).update_all(institute_id: institute.id)
 		end
 	end

 	desc "Import subject entities from csv"
	task courses: :environment do
 		filename = File.join(Rails.root, 'app', 'csv', 'SBJ.csv')
 		counter = 0

 		CSV.foreach(filename, headers: true) do |row|
 			subject_entity = SubjectEntity.create(pubukprn: row["PUBUKPRN"], ukprn: row["UKPRN"], kiscourseid: row["KISCOURSEID"], kismode: row["KISMODE"], sbj: row["SBJ"])
 			course = Course.find_by_kiscourseid(subject_entity.kiscourseid)
 			puts "#{course.title} - #{subject_entity.errors.full_messages.join(",")}" if subject_entity.errors.any?
 			counter += 1 if subject_entity.persisted?
 		end
 		puts "Imported #{counter} subject entities rows."
 	end

 	desc "Associate subject entities with courses"
 	task courses: :environment do
 		Course.find_each do |course|
 			SubjectEntity.where(kiscourseid: course.kiscourseid).update_all(course_id: course.id)
 		end
 	end

 	desc "Associate subject entities with institutes"
 	task courses: :environment do
 		Institute.find_each do |institute|
 			SubjectEntity.where(ukprn: institute.ukprn).update_all(institute_id: institute.id)
 		end
 	end

 	desc "Import entry tariffs from csv"
	task courses: :environment do
 		filename = File.join(Rails.root, 'app', 'csv', 'TARIFF.csv')
 		counter = 0

 		CSV.foreach(filename, headers: true) do |row|
 			tariff = Tariff.create(pubukprn: row["PUBUKPRN"], ukprn: row["UKPRN"], kiscourseid: row["KISCOURSEID"], kismode: row["KISMODE"], tarpop: row["TARPOP"], taragg: row["TARAGG"], tarsbj: row["TARSBJ"], t001: row["T001"], t048: row["T048"], t064: row["T064"], t080: row["T080"], t096: row["T096"], t112: row["T112"], t128: row["T128"], t144: row["T144"], t160: row["T160"], t176: row["T176"], t192: row["T192"], t208: row["T208"], t224: row["T224"], t240: row["T240"])
 			course = Course.find_by_kiscourseid(tariff.kiscourseid)
 			puts "#{course.title} - #{tariff.errors.full_messages.join(",")}" if tariff.errors.any?
 			counter += 1 if tariff.persisted?
 		end
 		puts "Imported #{counter} entry tariff rows."
 	end

 	desc "Associate subject entities with courses"
 	task courses: :environment do
 		Course.find_each do |course|
 			Tariff.where(kiscourseid: course.kiscourseid).update_all(course_id: course.id)
 		end
 	end

 	desc "Associate subject entities with institutes"
 	task courses: :environment do
 		Institute.find_each do |institute|
 			Tariff.where(ukprn: institute.ukprn).update_all(institute_id: institute.id)
 		end
 	end

 	desc "Import UCAS codes from csv"
	task courses: :environment do
 		filename = File.join(Rails.root, 'app', 'csv', 'UCASCOURSEID.csv')
 		counter = 0

 		CSV.foreach(filename, headers: true) do |row|
 			ucas = Uca.create(pubukprn: row["PUBUKPRN"], ukprn: row["UKPRN"], kiscourseid: row["KISCOURSEID"], kismode: row["KISMODE"], locid: row["locid"], ucascourseid: row["UCASCOURSEID"])
 			course = Course.find_by_kiscourseid(ucas.kiscourseid)
 			puts "#{course.title} - #{ucas.errors.full_messages.join(",")}" if ucas.errors.any?
 			counter += 1 if ucas.persisted?
 		end
 		puts "Imported #{counter} UCAS codes."
 	end

 	desc "Associate UCAS codes with courses"
 	task courses: :environment do
 		Course.find_each do |course|
 			Uca.where(kiscourseid: course.kiscourseid).update_all(course_id: course.id)
 		end
 	end

 	desc "Associate UCAS codes with institutes"
 	task courses: :environment do
 		Location.find_each do |location|
 			Uca.where(locid: location.locid).update_all(location_id: location.id)
 		end
 	end

 	desc "Associate UCAS codes with locations"
 	task courses: :environment do
 		Institute.find_each do |institute|
 			Uca.where(ukprn: institute.ukprn).update_all(institute_id: institute.id)
 		end
 	end




end
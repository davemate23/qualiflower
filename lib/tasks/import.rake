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
 		Institute.all.each do |institute|
 			school = institute.name
 			page = Wikipedia.find(school)
 			page = Wikipedia.find(school[3..-1].strip) if page.content.nil? and school[0..2].downcase == 'the'
 			next if page.content.nil?

 			description = page.summary
 			if page.image_urls.first == "https://upload.wikimedia.org/wikipedia/en/4/4a/Commons-logo.svg" 
 				image = page.image_urls.last
 			else
 				image = page.image_urls.first 				
 			end
 			institute.update!(description: description, image: image)
 		end
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

 	desc "Import continuation details from csv"
	task courses: :environment do
 		filename = File.join(Rails.root, 'app', 'csv', 'CONTINUATION.csv')
 		counter = 0

 		CSV.foreach(filename, headers: true) do |row|
 			continuation = Continuation.create(pubukprn: row["PUBUKPRN"], ukprn: row["UKPRN"], kiscourseid: row["KISCOURSEID"], kismode: row["CONTPOP"], contagg: row["CONTAGG"], contsbj: row["CONTSBJ"], ucont: row["UCONT"], udormant: row["UDORMANT"], ugained: row["UGAINED"], uleft: row["ULEFT"], ulower: row["ULOWER"])
 			puts "#{continuation.id} - #{continuation.errors.full_messages.join(",")}" if continuation.errors.any?
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
 			puts "#{accreditation.kiscourse} - #{accreditation.errors.full_messages.join(",")}" if accreditation.errors.any?
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
 			job = Job.create(pubukprn: row["PUBUKPRN"], ukprn: row["UKPRN"], kiscoursid: row["KISCOURSEID"], kismode: row["KISMODE"], comsbj: row["COMSBJ"], title: row["JOB"], perc: row["PERC"], order: row["ORDER"])
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
 			commonjobtype = CommonJobType.create(pubukprn: row["PUBUKPRN"], ukprn: row["UKPRN"], kiscoursid: row["KISCOURSEID"], kismode: row["KISMODE"], comsbj: row["COMSBJ"], compop: row["COMPOP"], comresp_rate: row["COMRESP_RATE"], comagg: row["COMAGG"])
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
 			jobtype = JobType.create(pubukprn: row["PUBUKPRN"], ukprn: row["UKPRN"], kiscoursid: row["KISCOURSEID"], kismode: row["KISMODE"], jobpop: row["JOBPOP"], jobresp_rate: row["JOBRESP_RATE"], jobagg: row["JOBAGG"], jobsbj: row["JOBSBJ"], profman: row["PROFMAN"], otherjob: row["OTHERJOB"], unkwn: ["UNKWN"])
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
 	

end
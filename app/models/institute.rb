class Institute < ApplicationRecord
	has_many :locations
	has_many :courses

	validates :ukprn, uniqueness: true

	mount_uploader :image, ImageUploader
	has_many :comments, as: :commentable, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy

  def self.search_results(search)
    if search
      institute =  Institute.search { fulltext "#{search}" }
    else
      institute =  Institute.order('created_at desc')
    end
  end

  # searchable do
  #   text :name,:ukprn,:country,:pubukprncountry
  #   string :name
  #   text :description
  #   string :description
  #   string :ukprn
  #   string :country
  #   string :pubukprncountry
  #
  # end


  def self.scrap_institutions



     $i = 0
     institutions=[]
    begin
      # puts("Inside the loop i = #$i" )
      api=Unistats.new('7KGKHK8R5HFY8L6FL4Z4')
      institutions << api.institutions($i)
      p $i
      $i +=1;
    end until api.institutions($i).count < 25
     p "+========++++==institutions+++++++"
     p institutions
     p "++++++++++++++++====edn +++++++++++=="

     institutions && institutions.flatten.each do |each_ele|
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


  def self.import_csv
    api=Unistats.new('7KGKHK8R5HFY8L6FL4Z4')
   CSV.foreach("/home/shivareddy/Desktop/projects/upwork/qualiflower/unistats/examples/INSTITUTION.csv", :headers => true) do |each_ele|
      # use row here...
      # institute = Institute.find_or_create_by(:ukprn=>each_ele["UKPRN"])
      # institute.suurl=each_ele["SUURL"]
      # institute.ukprn=each_ele["UKPRN"]
      # institute.pubukprn=each_ele["PUBUKPRN"]
      # institute.country=each_ele["COUNTRY"]
      # institute.pubukprncountry=each_ele["PUBUKPRNCOUNTRY"]
      # institute.tefmark=each_ele["TEFMARKER"]
      # institute.q24pop=each_ele["Q24POP"]
      # institute.q24=each_ele["Q24"]
      # institute.q24resp_rate=each_ele["Q24RESP_RATE"]
      # institute.save

     find_institute = Institute.where(:ukprn=> each_ele["UKPRN"])
     if !find_institute.present?
      p institute1 = api.institution(each_ele["UKPRN"])
      p "==========institute+++++++++"
      p parsed_response = institute1.parsed_response
      p "+++=end +++=="

      if parsed_response["ApiUrl"].present?

      institute = Institute.find_or_create_by(:ukprn=> parsed_response["ApiUrl"].split('/').last)
      institute.suurl= parsed_response["StudentUnionUrl"]
      institute.name= parsed_response["Name"]
      institute.pubukprn= parsed_response["PUBUKPRN"]
      institute.country= parsed_response["Country"]
      institute.pubukprncountry= parsed_response["PUBUKPRNCountry"]
      institute.tefmark= parsed_response["TEFMarker"]
      institute.q24pop= parsed_response["NSSQuestion24Population"]
      institute.q24= parsed_response["NSSQuestion24"]
      institute.q24resp_rate= parsed_response["NSSQuestion24ResponseRate"]
      institute.save


end

     end
     end


  end

def self.import

  api=Unistats.new('7KGKHK8R5HFY8L6FL4Z4')
  find_institute = Institute.where(:ukprn=> 10000163)
  if !find_institute.present?
    p institute1 = api.institution(10000824)
    p "==========institute+++++++++"
    p parsed_response = institute1.parsed_response
    p "+++=end +++=="


    p institute = Institute.find_or_create_by(:ukprn=> parsed_response["ApiUrl"].split('/').last)
    p 4444444444444444444444
    institute.suurl= parsed_response["StudentUnionUrl"]
    institute.name= parsed_response["Name"]
    institute.pubukprn= parsed_response["PUBUKPRN"]
    institute.country= parsed_response["Country"]
    institute.pubukprncountry= parsed_response["PUBUKPRNCountry"]
    institute.tefmark= parsed_response["TEFMarker"]
    institute.q24pop= parsed_response["NSSQuestion24Population"]
    institute.q24= parsed_response["NSSQuestion24"]
    institute.q24resp_rate= parsed_response["NSSQuestion24ResponseRate"]
    institute.save




  end

end



  end
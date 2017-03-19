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

  searchable do
    text :name,:ukprn,:country,:pubukprncountry
    string :name
    text :description
    string :description
    string :ukprn
    string :country
    string :pubukprncountry

  end


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





  end
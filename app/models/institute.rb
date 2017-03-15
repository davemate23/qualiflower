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

end

class Location < ApplicationRecord
  belongs_to :institute, optional: true
  has_many :courses
  mount_uploader :image, ImageUploader
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy

  def self.search_results(search)
    if search
     locations =  Location.search { fulltext "#{search}" }
    else
      locations =  Location.order('created_at desc')
    end
  end



  searchable do
    text :ukprn
    string :ukprn
    string :name
    float :lat
    float :long
    string :locid
    string :locukprn
    string :loccountry
    integer :privatelower
    integer :privateupper
    string :suurl
    string :accomurl
    integer :instbeds
    integer :instlower
    integer :instupper

  end


end

class Location < ApplicationRecord
  belongs_to :institute, optional: true
  has_many :courses
  searchkick
  mount_uploader :image, ImageUploader
end

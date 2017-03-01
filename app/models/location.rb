class Location < ApplicationRecord
  belongs_to :institute, optional: true
  has_many :courses
  mount_uploader :image, ImageUploader
end

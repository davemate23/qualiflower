class Location < ApplicationRecord
  belongs_to :institute, optional: true
  has_many :courses
end

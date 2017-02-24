class DegreeClass < ApplicationRecord
  belongs_to :course, optional: true
  belongs_to :institute, optional: true
end

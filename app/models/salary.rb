class Salary < ApplicationRecord
  belongs_to :course
  belongs_to :institute
end

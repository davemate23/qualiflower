class Employment < ApplicationRecord
  belongs_to :course_stat, optional: true
  belongs_to :institute, optional: true
end

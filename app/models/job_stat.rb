class JobStat < ApplicationRecord

  mount_uploader :image, ImageUploader
  has_many :courses
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :job

end

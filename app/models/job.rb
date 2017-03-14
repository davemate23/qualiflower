class Job < ApplicationRecord
  # acts_as_commentable
	mount_uploader :image, ImageUploader
	has_many :courses
	has_many :comments, as: :commentable, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy


  def self.search_results(search)
    if search
      jobs =  Job.search { fulltext "#{search}" }
    else
      jobs =  Job.order('created_at desc')
    end
  end

  searchable do
    string :alternativeernative
    text :description
    text :title
    string :title
    string :description
    string :pay
    string :hours
    text :entry
    string :entry
    text :skills
    text :duties
    text :salary
    text :working_hours
    text :career_path
    text :related
  end


end

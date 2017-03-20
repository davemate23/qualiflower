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
    # string :alternativeernative
    text :description, :as => :description_textp
    # text :title
    # string :title
    # string :description
    # string :pay
    # string :hours
    # text :entry
    # string :entry
    # text :skills
    # text :duties
    # text :salary
    # text :working_hours
    # text :career_path
    # text :related
  end

  def self.scrap_jobs

    require 'open-uri'
    require 'nokogiri'
    doc = Nokogiri::HTML(open("https://nationalcareersservice.direct.gov.uk/job-profiles/home"))
    # doc.css("#az-index-wrapper")
    links = doc.css("#az-index-wrapper ul li a").text()
    links.each_char do |each_ch|
      # profile = "https://nationalcareersservice.direct.gov.uk/job-profiles/#{each_ch}"

      profile_doc = Nokogiri::HTML(open("https://nationalcareersservice.direct.gov.uk/job-profiles/#{each_ch}"))
      profile_doc.css(".column-one-half ul.list li a").each do |each_profile|


        if !Job.where("title like ?", "%#{each_profile.text}%").present?
        profile_info_doc = Nokogiri::HTML(open("https://nationalcareersservice.direct.gov.uk#{each_profile["href"]}"))
        job = Job.find_or_create_by(title: profile_info_doc.css('.column-two-thirds h1').to_s)
        job.entry=profile_info_doc.css('#entry-requirements').to_s
        job.skills=profile_info_doc.css('#skills-required').to_s
        job.duties=profile_info_doc.css('#what-youll-do').to_s
        job.salary=profile_info_doc.css('#salary').to_s
        job.working_hours=profile_info_doc.css('#working-hours-patterns-and-environment').to_s
        job.career_path=profile_info_doc.css('#career-path-and-progression').to_s
        job.related=profile_info_doc.css('#career-path-and-progression').to_s
        job.pay=profile_info_doc.css('.profile .sixty').to_s
        job.hours=profile_info_doc.css('.profile .forty').to_s
        job.save
        p job

         end

      end


    end

  end


end

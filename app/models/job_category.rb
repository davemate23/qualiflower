class JobCategory < ApplicationRecord
  has_ancestry
  # acts_as_tree order: "name"


  def self.scrap_job_categories


    require 'open-uri'
    require 'nokogiri'
    url ="http://www.neighbourhood.statistics.gov.uk/HTMLDocs/dev3/ONS_SOC_hierarchy_view.html"
    0.upto(8) {|x|
      self.sureLoadLink(30){
    url="http://www.neighbourhood.statistics.gov.uk/HTMLDocs/dev3/data/SingleClass.html?soc=#{x+1}"
    browser = Watir::Browser.new(:phantomjs)
    browser.goto(url)
    page = Nokogiri::HTML(browser.html)
    major = JobCategory.find_or_create_by(:name=>page.css('#ons-style-border font').text)
    major.description=page.css('#ons-style-border')[1].css('#ons-style-box').text
    if page.css('#ons-style-border')[2].present? && page.css('#ons-style-border')[2].css('#ons-style-box').text.include?('Entry requirements of this job').present?
    major.entry = page.css('#ons-style-border')[2].css('#ons-style-box').text
    end
    if page.css('#ons-style-border')[3].present? && page.css('#ons-style-border')[3].css('#ons-style-box').text.include?('Tasks required by this job include').present?
      major.tasks = page.css('#ons-style-border')[3].css('#ons-style-box').to_s
    end
    if page.css('#ons-style-border')[5].present? && page.css('#ons-style-border')[4].css('#ons-style-box').text.include?('Jobs related to this code').present?
      major.related = page.css('#ons-style-border')[5].css('#ons-style-box').to_s
    end
    major.save
    page.css('#ons-style-border').last.css('#ons-style-box a').each do |each_sub_major|
    browser.goto("http://www.neighbourhood.statistics.gov.uk/HTMLDocs/dev3/data/#{each_sub_major["href"]}")
    sub_major_page = Nokogiri::HTML(browser.html)
    sub_major = JobCategory.find_or_create_by(:name=>sub_major_page.css('#ons-style-border font').text)
    sub_major.description=sub_major_page.css('#ons-style-border')[1].css('#ons-style-box').text
    if sub_major_page.css('#ons-style-border')[2].present? && sub_major_page.css('#ons-style-border')[2].css('#ons-style-box').text.include?('Entry requirements of this job').present?
      sub_major.entry = sub_major_page.css('#ons-style-border')[2].css('#ons-style-box').text
    end
    if sub_major_page.css('#ons-style-border')[3].present? && sub_major_page.css('#ons-style-border')[3].css('#ons-style-box').text.include?('Tasks required by this job include').present?
      sub_major.tasks = sub_major_page.css('#ons-style-border')[3].css('#ons-style-box').text
    end
    if sub_major_page.css('#ons-style-border')[5].present? && sub_major_page.css('#ons-style-border')[5].css('#ons-style-box').text.include?('Jobs related to this code').present?
      sub_major.related = sub_major_page.css('#ons-style-border')[5].css('#ons-style-box').to_s
    end
    sub_major.parent_id=major.id
    sub_major.save
    sub_major_page.css('#ons-style-border')[3].css('#ons-style-box a').each do |each_minor|
      browser.goto("http://www.neighbourhood.statistics.gov.uk/HTMLDocs/dev3/data/#{each_minor["href"]}")
      minor_page = Nokogiri::HTML(browser.html)
      minor = JobCategory.find_or_create_by(:name=>minor_page.css('#ons-style-border font').text)
      minor.description=minor_page.css('#ons-style-border')[1].css('#ons-style-box').text
      if minor_page.css('#ons-style-border')[2].present? && minor_page.css('#ons-style-border')[2].css('#ons-style-box').text.include?('Entry requirements of this job').present?
        minor.entry = minor_page.css('#ons-style-border')[2].css('#ons-style-box').text
      end
      if minor_page.css('#ons-style-border')[3].present? && minor_page.css('#ons-style-border')[3].css('#ons-style-box').text.include?('Tasks required by this job include').present?
        minor.tasks = minor_page.css('#ons-style-border')[3].css('#ons-style-box').to_s
      end
      if minor_page.css('#ons-style-border')[5].present? && minor_page.css('#ons-style-border')[5].css('#ons-style-box').text.include?('Jobs related to this code').present?
        minor.related = minor_page.css('#ons-style-border')[5].css('#ons-style-box').to_s
      end
      minor.parent_id=sub_major.id

      minor.save
      minor_page.css('#ons-style-border')[3].css('#ons-style-box a').each do |each_unit|
          browser.goto("http://www.neighbourhood.statistics.gov.uk/HTMLDocs/dev3/data/#{each_unit["href"]}")
          unit_page = Nokogiri::HTML(browser.html)
          unit = JobCategory.find_or_create_by(:name=>unit_page.css('#ons-style-border font').text)
          unit.description=unit_page.css('#ons-style-border')[1].css('#ons-style-box').text
          unit.parent_id=minor.id
          if unit_page.css('#ons-style-border')[2].present? && unit_page.css('#ons-style-border')[2].css('#ons-style-box').text.include?('Entry requirements of this job').present?
            unit.entry = unit_page.css('#ons-style-border')[2].css('#ons-style-box').text
          end
          if unit_page.css('#ons-style-border')[3].present? && unit_page.css('#ons-style-border')[3].css('#ons-style-box').text.include?('Tasks required by this job include').present?
            unit.tasks = unit_page.css('#ons-style-border')[3].css('#ons-style-box').to_s
          end
          if unit_page.css('#ons-style-border')[5].present? && unit_page.css('#ons-style-border')[5].css('#ons-style-box').text.include?('Jobs related to this code').present?
            unit.tasks = unit_page.css('#ons-style-border')[5].css('#ons-style-box').to_s
          end
          p "=========minor"
          unit.save
          # p unit.errors
        end
      end
    end
      }
    }

  end


  def self.sureLoadLink(mytimeout)
    browser_loaded=0
    while (browser_loaded == 0)
      begin
        browser_loaded=1
        Timeout::timeout(mytimeout)  do
          yield
        end
      rescue Timeout::Error => e
        puts "Page load timed out: #{e}"
        browser_loaded=0
        retry
      end
    end
  end





end

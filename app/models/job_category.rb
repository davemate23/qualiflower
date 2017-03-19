class JobCategory < ApplicationRecord
  has_ancestry


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
    major.save
    page.css('#ons-style-border').last.css('#ons-style-box a').each do |each_sub_major|
    browser.goto("http://www.neighbourhood.statistics.gov.uk/HTMLDocs/dev3/data/#{each_sub_major["href"]}")
    sub_major_page = Nokogiri::HTML(browser.html)
    sub_major = JobCategory.find_or_create_by(:name=>sub_major_page.css('#ons-style-border font').text)
    sub_major.description=sub_major_page.css('#ons-style-border')[1].css('#ons-style-box').text
    sub_major.parent_id=major.id
    sub_major.save
    sub_major_page.css('#ons-style-border')[3].css('#ons-style-box a').each do |each_minor|
      browser.goto("http://www.neighbourhood.statistics.gov.uk/HTMLDocs/dev3/data/#{each_minor["href"]}")
      minor_page = Nokogiri::HTML(browser.html)
      minor = JobCategory.find_or_create_by(:name=>minor_page.css('#ons-style-border font').text)
      minor.description=minor_page.css('#ons-style-border')[1].css('#ons-style-box').text
      minor.parent_id=sub_major.id
      minor.save
      minor_page.css('#ons-style-border')[3].css('#ons-style-box a').each do |each_unit|
          browser.goto("http://www.neighbourhood.statistics.gov.uk/HTMLDocs/dev3/data/#{each_unit["href"]}")
          unit_page = Nokogiri::HTML(browser.html)
          unit = JobCategory.find_or_create_by(:name=>unit_page.css('#ons-style-border font').text)
          unit.description=unit_page.css('#ons-style-border')[1].css('#ons-style-box').text
          unit.parent_id=minor.id
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

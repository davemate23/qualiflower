class RenameAndAddColumnsToCourses < ActiveRecord::Migration[5.0]
  def change
  	rename_column :courses, :name, :title
  	rename_column :courses, :cost, :engfee
  	add_column :courses, :pubukprn, :string
  	add_column :courses, :ukprn, :string, index: true
  	add_column :courses, :assurl, :string
  	add_column :courses, :crseurl, :string
  	add_column :courses, :distance, :boolean
  	add_column :courses, :employurl, :string
  	add_column :courses, :feetbc, :boolean
  	add_column :courses, :honours, :boolean
  	add_column :courses, :foundation, :integer
  	add_column :courses, :jacs1, :string
  	add_column :courses, :jacs2, :string
  	add_column :courses, :jacs3, :string
  	add_column :courses, :kiscourseid, :string, index: true
  	add_column :courses, :kismode, :integer
  	add_column :courses, :kistype, :integer
  	add_column :courses, :ldcs1, :string
  	add_column :courses, :ldcs2, :string
  	add_column :courses, :ldcs3, :string
  	add_column :courses, :level, :string
  	add_column :courses, :locchng, :boolean
  	add_column :courses, :lturl, :string
  	add_column :courses, :meanssup, :boolean
  	add_column :courses, :nhs, :boolean
  	add_column :courses, :nifee, :integer
  	add_column :courses, :noncreditassess, :boolean
  	add_column :courses, :numstage, :integer
  	add_column :courses, :othsup, :boolean
  	add_column :courses, :relatedkis1, :string
  	add_column :courses, :relatedkis2, :string
  	add_column :courses, :relatedkis3, :string
  	add_column :courses, :sandwich, :integer
  	add_column :courses, :scotfee, :integer
  	add_column :courses, :supporturl, :string
  	add_column :courses, :ucasprogid, :string, index: true
  	add_column :courses, :ukprnapply, :string
  	add_column :courses, :varfee, :integer
  	add_column :courses, :wafee, :integer
  	add_column :courses, :waiver, :boolean
  	add_column :courses, :welsh, :integer
  	add_column :courses, :yearabroad, :integer
  	add_column :courses, :kisaim, :integer
  	add_column :courses, :avgwritten, :integer
  	add_column :courses, :avgcoursework, :integer
  	add_column :courses, :avgscheduled, :integer


  end
end

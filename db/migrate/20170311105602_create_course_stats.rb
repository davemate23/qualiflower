class CreateCourseStats < ActiveRecord::Migration[5.0]
  def change
    create_table :course_stats do |t|
      t.string :title
      t.integer :engfee
      t.string :pubukprn
      t.string :ukprn, index: true
      t.string :assurl
      t.string :crseurl
      t.boolean :distance
      t.string :employurl
      t.boolean :feetbc
      t.boolean :honours
      t.integer :foundation
      t.string :jacs1
      t.string :jacs2
      t.string :jacs3
      t.string :kiscourseid, index: true
      t.integer :kismode
      t.integer :kistype
      t.string :ldcs1
      t.string :ldcs2
      t.string :ldcs3
      t.string :level
      t.boolean :locchnge
      t.string :lturl
      t.boolean :meanssup
      t.boolean :nhs
      t.integer :nifee
      t.boolean :noncreditassess
      t.integer :numstage
      t.boolean :othsup
      t.string :relatedkis1
      t.string :relatedkis2
      t.string :relatedkis3
      t.integer :sandwich
      t.integer :scotfee
      t.string :supporturl
      t.string :ucasprogid, index: true
      t.string :ukprnapply
      t.integer :varfee
      t.integer :wafee
      t.boolean :waiver
      t.integer :welsh
      t.integer :yearabroad
      t.integer :kisaim
      t.integer :avgwritten
      t.integer :avgcoursework
      t.integer :avgscheduled
      t.references :location, foreign_key: true
      t.references :institute, foreign_key: true
      t.references :course, foreign_key: true

      t.timestamps
    end


  end
end

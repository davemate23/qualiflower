class ChangeTableJob < ActiveRecord::Migration[5.0]

    def self.up
      change_table(:jobs)  do |t|
        t.remove :pubukprn, :kiscourseid,:ukprn, :kismode, :comsbj, :perc, :order
        t.string :alternativeernative
        t.text :description
        t.string :pay
        t.string :hours
        t.text :entry
        t.text :skills
        t.text :duties
        t.text :salary
        t.text :working_hours
        t.text :career_path
        t.text :related
        t.text :title
        t.references :course
        # t.references :location, foreign_key: true
        t.references :institute, foreign_key: true
      end
    end

    def self.down
      change_table(:jobs)  do |t|
        t.remove :alternativeernative,:description, :pay,:hours, :entry, :skills, :duties, :salary,:working_hours,:career_path,:related,:course_id
        t.string :pubukprn
        t.text :kiscourseid
        t.string :kismode
        t.string :comsbj
        t.text :perc
        t.text :order
        t.text :ukprn
   end
   end

end

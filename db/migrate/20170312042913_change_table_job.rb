class ChangeTableJob < ActiveRecord::Migration[5.0]
  def change
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


    end



  end
end

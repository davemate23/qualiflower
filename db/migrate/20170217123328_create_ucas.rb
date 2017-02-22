class CreateUcas < ActiveRecord::Migration[5.0]
  def change
    create_table :ucas do |t|
      t.string :pubukprn
      t.string :ukprn
      t.string :kiscourseid
      t.integer :kismode
      t.string :locid
      t.integer :ucascourseid
      t.references :course, foreign_key: true
      t.references :institute, foreign_key: true
      t.references :location, foreign_key: true

      t.timestamps
    end
  end
end

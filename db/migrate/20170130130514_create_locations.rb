class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :ukprn
      t.text :name
      t.decimal :lat
      t.decimal :long
      t.string :locid, index: true
      t.string :locukprn
      t.string :loccountry
      t.integer :privatelower
      t.integer :privateupper
      t.string :suurl
      t.string :accomurl
      t.integer :instbeds
      t.integer :instlower
      t.integer :instupper
      t.references :institute, foreign_key: true, index: true

      t.timestamps
    end
    add_index :locations, :ukprn
    add_index :locations, :locid
  end
end

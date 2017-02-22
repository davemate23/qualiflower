class CreateDegreeClasses < ActiveRecord::Migration[5.0]
  def change
    create_table :degree_classes do |t|
      t.string :pubukprn
      t.string :ukprn
      t.string :kiscourseid
      t.integer :kismode
      t.integer :degpop
      t.integer :degagg
      t.integer :degsbj
      t.integer :ufirst
      t.integer :uupper
      t.integer :ulower
      t.integer :uother
      t.integer :uordinary
      t.integer :udistinction
      t.integer :umerit
      t.integer :upass
      t.integer :una
      t.references :course, foreign_key: true
      t.references :institute, foreign_key: true

      t.timestamps
    end
  end
end

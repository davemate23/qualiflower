class CreateEmployments < ActiveRecord::Migration[5.0]
  def change
    create_table :employments do |t|
      t.string :pubukprn
      t.string :ukprn
      t.string :kiscourseid
      t.integer :kismode
      t.integer :emppop
      t.integer :empresp_rate
      t.integer :empagg
      t.integer :empsbj
      t.integer :workstudy
      t.integer :study
      t.integer :assunemp
      t.integer :both
      t.integer :noavail
      t.integer :work
      t.references :course, foreign_key: true
      t.references :institute, foreign_key: true

      t.timestamps
    end
  end
end

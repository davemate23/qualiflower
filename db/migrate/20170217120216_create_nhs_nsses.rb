class CreateNhsNsses < ActiveRecord::Migration[5.0]
  def change
    create_table :nhs_nsses do |t|
      t.string :pubukprn
      t.string :ukprn
      t.string :kiscourseid
      t.integer :kismode
      t.integer :nhspop
      t.integer :nhsresp_rate
      t.integer :nhsagg
      t.integer :nhssbj
      t.integer :nhsq1
      t.integer :nhsq2
      t.integer :nhsq3
      t.integer :nhsq4
      t.integer :nhsq5
      t.integer :nhsq6
      t.references :course, foreign_key: true
      t.references :institute, foreign_key: true

      t.timestamps
    end
  end
end

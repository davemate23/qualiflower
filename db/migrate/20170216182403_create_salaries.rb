class CreateSalaries < ActiveRecord::Migration[5.0]
  def change
    create_table :salaries do |t|
      t.string :pubukprn
      t.string :ukprn
      t.string :kiscourseid
      t.integer :kismode
      t.integer :salpop
      t.integer :salresp_rate
      t.integer :salagg
      t.integer :salsbj
      t.integer :ldlq
      t.integer :ldmed
      t.integer :ldmed
      t.integer :lduq
      t.integer :lq
      t.integer :med
      t.integer :uq
      t.integer :instlq
      t.integer :instmed
      t.integer :instuq
      t.references :course, foreign_key: true
      t.references :institute, foreign_key: true

      t.timestamps
    end
  end
end

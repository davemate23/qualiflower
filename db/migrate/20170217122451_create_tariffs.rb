class CreateTariffs < ActiveRecord::Migration[5.0]
  def change
    create_table :tariffs do |t|
      t.string :pubukprn
      t.string :ukprn
      t.string :kiscourseid
      t.integer :kismode
      t.integer :tarpop
      t.integer :taragg
      t.integer :tarsbj
      t.integer :t001
      t.integer :t048
      t.integer :t064
      t.integer :t080
      t.integer :t096
      t.integer :t112
      t.integer :t128
      t.integer :t144
      t.integer :t160
      t.integer :t176
      t.integer :t192
      t.integer :t208
      t.integer :t224
      t.integer :t240
      t.references :course, foreign_key: true
      t.references :institute, foreign_key: true

      t.timestamps
    end
  end
end

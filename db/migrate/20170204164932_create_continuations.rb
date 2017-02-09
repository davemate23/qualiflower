class CreateContinuations < ActiveRecord::Migration[5.0]
  def change
    create_table :continuations do |t|
      t.string :pubukprn
      t.string :ukprn
      t.string :kiscourseid
      t.integer :kismode
      t.integer :contpop
      t.integer :contagg
      t.string :contsbj
      t.integer :ucont
      t.integer :udormant
      t.integer :ugained
      t.integer :uleft
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end

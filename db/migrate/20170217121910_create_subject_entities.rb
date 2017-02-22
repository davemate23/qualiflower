class CreateSubjectEntities < ActiveRecord::Migration[5.0]
  def change
    create_table :subject_entities do |t|
      t.string :pubukprn
      t.string :ukprn
      t.string :kiscourseid
      t.integer :kismode
      t.integer :sbj
      t.string :subject
      t.references :course, foreign_key: true
      t.references :institute, foreign_key: true

      t.timestamps
    end
  end
end

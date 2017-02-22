class CreateCourseStages < ActiveRecord::Migration[5.0]
  def change
    create_table :course_stages do |t|
      t.string :pubukprn
      t.string :ukprn
      t.string :kiscourseid
      t.integer :kismode
      t.string :assact
      t.integer :coursework
      t.integer :independent
      t.string :ltact
      t.integer :placement
      t.integer :practical
      t.integer :scheduled
      t.integer :stage
      t.integer :written
      t.references :course, foreign_key: true
      t.references :institute, foreign_key: true

      t.timestamps
    end
  end
end

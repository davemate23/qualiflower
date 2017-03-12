class CreateJobStats < ActiveRecord::Migration[5.0]
  def change
   create_table :job_stats do |t|
      t.text :title
      t.string :pubukprn
      t.string :ukprn
      t.string :kiscourseid
      t.integer :kismode
      t.string :comsbj
      t.integer :perc
      t.integer :order
      t.references :course, foreign_key: true
      t.references :job, foreign_key: true

      t.timestamps
    end

  end
end

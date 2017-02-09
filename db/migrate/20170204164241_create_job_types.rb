class CreateJobTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :job_types do |t|
      t.string :pubukprn
      t.string :ukprn
      t.string :kiscourseid
      t.integer :kismode
      t.integer :jobpop
      t.integer :jobresp_rate
      t.integer :jobagg
      t.string :jobsbj
      t.integer :profman
      t.integer :otherjob
      t.integer :unkwn
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end

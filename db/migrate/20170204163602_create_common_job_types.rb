class CreateCommonJobTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :common_job_types do |t|
      t.string :pubukprn
      t.string :ukprn
      t.string :kiscoursid
      t.integer :kismode
      t.integer :compop
      t.integer :comresp_rate
      t.integer :comagg
      t.string :comsbj
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end

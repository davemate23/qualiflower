class CreateQualifications < ActiveRecord::Migration[5.0]
  def change
    create_table :qualifications do |t|
      t.integer :kisaimcode
      t.string :name
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end

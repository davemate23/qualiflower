class CreateJobCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :job_categories do |t|
      t.string :name
      t.text :description
      t.text :entry
      t.text :tasks
      t.text :related
      t.integer :parent_id

      t.timestamps
    end
    add_index :job_categories, :parent_id
  end
end

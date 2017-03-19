class AddAncestryToJobCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :job_categories, :ancestry, :string
    add_index :job_categories, :ancestry
  end

end

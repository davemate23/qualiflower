class AddImageToModels < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :image, :string
    rename_column :institutes, :picture, :image
    add_column :jobs, :image, :string
    add_column :locations, :image, :string
  end
end

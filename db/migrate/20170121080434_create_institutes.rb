class CreateInstitutes < ActiveRecord::Migration[5.0]
  def change
    create_table :institutes do |t|
      t.string :name
      t.text :description
      t.string :picture
      t.string :url

      t.timestamps
    end
  end
end

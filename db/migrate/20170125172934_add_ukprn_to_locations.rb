class AddUkprnToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :ukprn, :string
    add_index :locations, :ukprn
  end
end

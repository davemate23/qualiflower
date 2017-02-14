class AddLocationToCourse < ActiveRecord::Migration[5.0]
  def change
  	add_column :courses, :location_id, :integer
  end
end

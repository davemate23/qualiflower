class AddUlowerToContinuation < ActiveRecord::Migration[5.0]
  def change
  	add_column :continuations, :ulower, :integer
  end
end

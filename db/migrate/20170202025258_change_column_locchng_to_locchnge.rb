class ChangeColumnLocchngToLocchnge < ActiveRecord::Migration[5.0]
  def change
  	rename_column :courses, :locchng, :locchnge
  end
end

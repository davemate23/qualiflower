class AddRemainingColumnsToInstitutes < ActiveRecord::Migration[5.0]
  def change
  	add_column :institutes, :pubukprn, :string
  	add_column :institutes, :country, :string
  	add_column :institutes, :pubukprncountry, :string
  	add_column :institutes, :tefmark, :boolean
  	add_column :institutes, :q24, :integer
  	add_column :institutes, :q24pop, :integer
  	add_column :institutes, :q24resp_rate, :integer
  	rename_column :institutes, :url, :suurl
  	remove_column :institutes, :instid
  end
end

class AddUkprnInstidToInstitutes < ActiveRecord::Migration[5.0]
  def change
    add_column :institutes, :ukprn, :string
    add_column :institutes, :instid, :integer
  end
end

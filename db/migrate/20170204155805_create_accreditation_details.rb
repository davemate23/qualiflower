class CreateAccreditationDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :accreditation_details do |t|
      t.string :accurl
      t.text :acctext
      t.string :acctype, index: true
      t.references :accreditation, foreign_key: true

      t.timestamps
    end
  end
end

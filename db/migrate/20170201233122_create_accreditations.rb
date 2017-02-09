class CreateAccreditations < ActiveRecord::Migration[5.0]
  def change
    create_table :accreditations do |t|
      t.string :ukprn
      t.string :pubukprn
      t.string :kiscourse
      t.string :accurl
      t.text :acctext
      t.string :acctype
      t.integer :kismode
      t.integer :accdepend
      t.string :accdependurl
      t.references :course, foreign_key: true

      t.timestamps
    end
    add_index :accreditations, :kiscourse
    add_index :accreditations, :acctype
  end
end

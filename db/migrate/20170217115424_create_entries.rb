class CreateEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :entries do |t|
      t.string :pubukprn
      t.string :ukprn
      t.string :kiscourseid
      t.integer :kismode
      t.integer :entpop
      t.integer :entagg
      t.integer :entsbj
      t.integer :access
      t.integer :alevel
      t.integer :bacc
      t.integer :degree
      t.integer :foundtn
      t.integer :noquals
      t.integer :other
      t.integer :otherhe
      t.references :course, foreign_key: true
      t.references :institute, foreign_key: true

      t.timestamps
    end
  end
end

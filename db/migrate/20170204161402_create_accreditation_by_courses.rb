class CreateAccreditationByCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :accreditation_by_courses do |t|
      t.string :accbodyname
      t.text :acctype
      t.string :hep
      t.string :kiscoursetitle
      t.string :kiscourseid
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end

class CreateJobProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :job_profiles do |t|
      t.string :title
      t.string :alternativeernative
      t.text :description
      t.string :pay
      t.string :hours
      t.text :entry
      t.text :skills
      t.text :duties
      t.text :salary
      t.text :working_hours
      t.text :career_path
      t.text :related

      t.timestamps
    end
  end
end

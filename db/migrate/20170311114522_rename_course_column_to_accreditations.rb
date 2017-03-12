class RenameCourseColumnToAccreditations < ActiveRecord::Migration[5.0]
  def change

    rename_column :accreditations, :course_id, :course_stat_id

  end
end

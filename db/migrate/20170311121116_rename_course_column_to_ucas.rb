class RenameCourseColumnToUcas < ActiveRecord::Migration[5.0]
  def change
    rename_column :ucas, :course_id, :course_stat_id
  end
end

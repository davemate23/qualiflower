class RenameCourseColumnToQualifications < ActiveRecord::Migration[5.0]
  def change
    rename_column :qualifications, :course_id, :course_stat_id
  end
end
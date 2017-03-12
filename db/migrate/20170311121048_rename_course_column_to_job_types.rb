class RenameCourseColumnToJobTypes < ActiveRecord::Migration[5.0]
  def change
    rename_column :job_types, :course_id, :course_stat_id
  end
end

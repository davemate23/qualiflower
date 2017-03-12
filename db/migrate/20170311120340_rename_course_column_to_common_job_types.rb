class RenameCourseColumnToCommonJobTypes < ActiveRecord::Migration[5.0]
  def change
    rename_column :common_job_types, :course_id, :course_stat_id
  end
end

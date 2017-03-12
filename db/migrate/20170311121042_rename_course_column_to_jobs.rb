class RenameCourseColumnToJobs < ActiveRecord::Migration[5.0]
  def change
    rename_column :jobs, :course_id, :course_stat_id
  end
end

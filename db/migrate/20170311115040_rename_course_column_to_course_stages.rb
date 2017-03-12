class RenameCourseColumnToCourseStages < ActiveRecord::Migration[5.0]
  def change
    rename_column :course_stages, :course_id, :course_stat_id
  end
end

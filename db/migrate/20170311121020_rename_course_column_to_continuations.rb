class RenameCourseColumnToContinuations < ActiveRecord::Migration[5.0]
  def change
    rename_column :continuations, :course_id, :course_stat_id
  end
end

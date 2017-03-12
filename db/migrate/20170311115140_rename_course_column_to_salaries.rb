class RenameCourseColumnToSalaries < ActiveRecord::Migration[5.0]
  def change
    rename_column :salaries, :course_id, :course_stat_id

  end
end

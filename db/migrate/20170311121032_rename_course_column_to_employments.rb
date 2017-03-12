class RenameCourseColumnToEmployments < ActiveRecord::Migration[5.0]
  def change
    rename_column :employments, :course_id, :course_stat_id
  end
end

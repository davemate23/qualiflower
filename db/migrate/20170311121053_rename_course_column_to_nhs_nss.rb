class RenameCourseColumnToNhsNss < ActiveRecord::Migration[5.0]
  def change
    rename_column :nhs_nsses, :course_id, :course_stat_id
  end
end

class RenameCourseColumnToEntries < ActiveRecord::Migration[5.0]
  def change
    rename_column :entries, :course_id, :course_stat_id
  end
end

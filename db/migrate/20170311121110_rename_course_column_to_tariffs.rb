class RenameCourseColumnToTariffs < ActiveRecord::Migration[5.0]
  def change
    rename_column :tariffs, :course_id, :course_stat_id
  end
end

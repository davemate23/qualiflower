class RenameCourseColumnToDegreeClasses < ActiveRecord::Migration[5.0]
  def change
    rename_column :degree_classes, :course_id, :course_stat_id
  end
end

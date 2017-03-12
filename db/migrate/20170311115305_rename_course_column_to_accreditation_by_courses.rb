class RenameCourseColumnToAccreditationByCourses < ActiveRecord::Migration[5.0]
  def change
    rename_column :accreditation_by_courses, :course_id, :course_stat_id

  end
end

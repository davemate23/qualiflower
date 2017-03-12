class RenameCourseColumnToSubjectEntities < ActiveRecord::Migration[5.0]
  def change
    rename_column :subject_entities, :course_id, :course_stat_id
  end
end

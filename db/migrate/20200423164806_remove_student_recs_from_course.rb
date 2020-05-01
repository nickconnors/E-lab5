class RemoveStudentRecsFromCourse < ActiveRecord::Migration[5.2]
  def change
    remove_column :courses, :student_recs, :text
  end
end

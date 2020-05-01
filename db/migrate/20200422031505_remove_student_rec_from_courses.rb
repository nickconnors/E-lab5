class RemoveStudentRecFromCourses < ActiveRecord::Migration[5.2]
  def change
    remove_column :courses, :student_rec, :string
  end
end

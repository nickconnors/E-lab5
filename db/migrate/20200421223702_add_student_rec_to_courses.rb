class AddStudentRecToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :student_rec, :string
  end
end

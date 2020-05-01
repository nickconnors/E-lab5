class RemoveCourseFromStudents < ActiveRecord::Migration[5.2]
  def change
    remove_reference :students, :course, foreign_key: true
  end
end

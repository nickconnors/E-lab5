class AddStudentRefToGrades < ActiveRecord::Migration[5.2]
  def change
    add_reference :grades, :student, foreign_key: true
  end
end

class AddStudentRecsToCourse < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :student_recs, :text, default: [].to_yaml
  end
end

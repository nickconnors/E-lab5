class AddGraderToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :grader, :string
  end
end

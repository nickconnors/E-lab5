class RemoveStageFromStudents < ActiveRecord::Migration[5.2]
  def change
    remove_column :students, :stage, :text
  end
end

class RemovePreferencesFromStudents < ActiveRecord::Migration[5.2]
  def change
    remove_column :students, :preferences, :text
  end
end

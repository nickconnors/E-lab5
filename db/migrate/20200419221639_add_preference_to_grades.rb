class AddPreferenceToGrades < ActiveRecord::Migration[5.2]
  def change
    add_column :grades, :preference, :boolean
  end
end

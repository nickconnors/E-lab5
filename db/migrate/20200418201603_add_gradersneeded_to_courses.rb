class AddGradersneededToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :gradersneeded, :integer
  end
end

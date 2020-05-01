class AddGradersfilledToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :gradersfilled, :integer
  end
end

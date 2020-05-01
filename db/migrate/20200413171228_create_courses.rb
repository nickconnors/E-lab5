class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :class_id
      t.integer :section
      t.string :component
      t.string :days
      t.time :start
      t.time :end
      t.string :location
      t.string :professor

      t.timestamps
    end
  end
end

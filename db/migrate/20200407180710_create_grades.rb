class CreateGrades < ActiveRecord::Migration[5.2]
  def change
    create_table :grades do |t|
      t.string :section
      t.string :grade

      t.timestamps
    end
  end
end

class CreateEvaluations < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluations do |t|
      t.string :firstname
      t.string :lastname
      t.integer :dotnumber
      t.string :class_id
      t.string :email
      t.integer :rating
      t.string :review

      t.timestamps
    end
  end
end

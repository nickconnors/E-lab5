class CreateRecommendations < ActiveRecord::Migration[5.2]
  def change
    create_table :recommendations do |t|
      t.string :firstname
      t.string :lastname
      t.integer :dotnumber
      t.string :class_id
      t.integer :section
      t.string :component
      t.string :days
      t.time :start
      t.time :end


      t.timestamps
    end
  end
end

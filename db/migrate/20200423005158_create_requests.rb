class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.string :firstname
      t.string :lastname
      t.integer :dotnumber
      t.string :class_id
      t.integer :section

      t.timestamps
    end
  end
end

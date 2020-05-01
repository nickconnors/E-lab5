class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :firstname
      t.string :lastname
      t.integer :dotnumber
      t.time :mondaystart
      t.time :mondayend
      t.time :tuesdaystart
      t.time :tuesdayend
      t.time :wednesdaystart
      t.time :wednesdayend
      t.time :thursdaystart
      t.time :thursdayend
      t.time :fridaystart
      t.time :fridayend

      t.timestamps
    end
  end
end

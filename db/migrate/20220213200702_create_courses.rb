class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses, id: false do |t|
      t.string :name
      t.string :description
      t.string :instructor_name
      t.string :weekday1
      t.string :weekday2
      t.time :start_time
      t.time :end_time
      t.string :code, primary_key: true
      t.integer :capacity
      t.integer :waitlist_capacity
      t.string :status
      t.string :room
      t.references :instructor, null: false, foreign_key: true

      t.timestamps
    end
    add_index :courses, :code, unique: true
  end
end

class MakeInstructorNameUnique < ActiveRecord::Migration[7.0]
  def change
    add_index :instructors, :name, unique: true
  end
end

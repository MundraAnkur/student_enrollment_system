class AddKeysToEnroll < ActiveRecord::Migration[7.0]
  def change
    add_column :enrolls, :course_id, :string, index: true
    add_column :enrolls, :student_id, :string, index: true

    add_foreign_key :enrolls, :courses, column: :course_id, primary_key: :code, on_delete: :cascade
    add_foreign_key :enrolls, :students, column: :student_id, primary_key: :student_id, on_delete: :cascade
  end
end

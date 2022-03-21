class ChangeDefaultValueOfStatusInCourse < ActiveRecord::Migration[7.0]
  def change
    change_column_default :courses, :status, 'OPEN'
  end
end

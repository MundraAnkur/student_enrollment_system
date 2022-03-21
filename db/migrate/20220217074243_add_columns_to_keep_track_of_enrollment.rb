class AddColumnsToKeepTrackOfEnrollment < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :enrolled, :integer, default: 0
    add_column :courses, :wait_listed, :integer, default: 0
  end
end

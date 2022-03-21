class CreateEnrolls < ActiveRecord::Migration[7.0]
  def change
    create_table :enrolls do |t|

      t.timestamps
    end
  end
end

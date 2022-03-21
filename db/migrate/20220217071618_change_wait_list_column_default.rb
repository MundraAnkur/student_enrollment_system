class ChangeWaitListColumnDefault < ActiveRecord::Migration[7.0]
  def change
    change_column_default :enrolls, :waitlist, false
  end
end

class AddWaitlistToEnrolls < ActiveRecord::Migration[7.0]
  def change
    add_column :enrolls, :waitlist, :string
  end
end

class ChangePhoneTypeToString < ActiveRecord::Migration[7.0]
  def change
    change_column :students, :phone, :string
  end
end

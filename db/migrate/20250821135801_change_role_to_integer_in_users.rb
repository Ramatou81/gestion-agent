class ChangeRoleToIntegerInUsers < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :role, :integer, default: 2, null: false
  end
end

class AddDetailsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :phone, :string
    add_column :users, :address, :string
    add_column :users, :birth_date, :date
    add_column :users, :hire_date, :date
  end
end

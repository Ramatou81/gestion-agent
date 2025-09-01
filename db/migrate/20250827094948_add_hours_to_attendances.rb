class AddHoursToAttendances < ActiveRecord::Migration[8.0]
  def change
    add_column :attendances, :hours, :float
  end
end

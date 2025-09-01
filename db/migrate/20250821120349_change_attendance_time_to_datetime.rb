class ChangeAttendanceTimeToDatetime < ActiveRecord::Migration[8.0]
  def change
    change_column :attendances, :check_in, :datetime
    change_column :attendances, :check_out, :datetime
    remove_column :attendances, :date, :date
  end
end

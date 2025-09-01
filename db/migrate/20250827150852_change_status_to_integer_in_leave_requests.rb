class ChangeStatusToIntegerInLeaveRequests < ActiveRecord::Migration[8.0]
  def up
    # Ajouter temporairement une colonne integer
    add_column :leave_requests, :status_temp, :integer, default: 0, null: false

    # Convertir les anciens status string en integer
    LeaveRequest.reset_column_information
    LeaveRequest.find_each do |lr|
      lr.update_column(:status_temp, case lr.status
        when "pending" then 0
        when "approved" then 1
        when "rejected" then 2
        else 0
      end)
    end

    # Supprimer l’ancienne colonne et renommer la nouvelle
    remove_column :leave_requests, :status
    rename_column :leave_requests, :status_temp, :status
  end

  def down
    add_column :leave_requests, :status_old, :string
    LeaveRequest.reset_column_information
    LeaveRequest.find_each do |lr|
      lr.update_column(:status_old, LeaveRequest.statuses.key(lr.status))
    end
    remove_column :leave_requests, :status
    rename_column :leave_requests, :status_old, :status
  end
end

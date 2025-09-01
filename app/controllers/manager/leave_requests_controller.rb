class Manager::LeaveRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_leave_request, only: [:update]

  def index
    # tous les congés des agents du manager
    @leave_requests = LeaveRequest.joins(:agent)
                                  .where(agents: { manager_id: current_user.id })
                                  .order(created_at: :desc)
  end

  def update
    if @leave_request.update(status: params[:status])
      redirect_to manager_leave_requests_path, notice: "La demande a été mise à jour."
    else
      redirect_to manager_leave_requests_path, alert: "Erreur lors de la mise à jour."
    end
  end

  private

  def set_leave_request
    @leave_request = LeaveRequest.find(params[:id])
  end
end

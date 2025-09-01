
# app/controllers/manager/agents_controller.rb
class Manager::AgentsController < ApplicationController
  before_action :set_agent, only: [:show]

  # GET /manager/agents
   def index
    @agents = Agent.where(department_id: current_user.department_id)
  end

  # GET /manager/agents/:id
  def show
    # @agent est défini dans set_agent
  end

  private

  def set_agent
    @agent = Agent.find_by(id: params[:id], manager_id: current_user.id)
    redirect_to manager_agents_path, alert: "Agent introuvable" unless @agent
  end
end

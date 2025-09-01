
module Admin
  class AgentsController < ApplicationController
    before_action :set_agent, only: %i[show edit update destroy]

    # GET /admin/agents
    def index
      @agents = Agent.all
    end

    # GET /admin/agents/:id
    def show
      # @agent déjà défini par set_agent
      # Récupérer toutes les présences, triées par date décroissante
      @attendances = @agent.attendances.order(check_in: :desc)
    end

    # GET /admin/agents/new
    def new
      @agent = Agent.new
    end

    # POST /admin/agents
   def create
  @agent = Agent.new(agent_params)

  if Agent.exists?(email: @agent.email)
    flash[:alert] = "Cet email est déjà utilisé par un autre agent."
    render :new
    return
  end

  if @agent.save
    flash[:notice] = "Agent créé avec succès."
    redirect_to admin_agents_path
  else
    render :new
  end
end

    # GET /admin/agents/:id/edit
    def edit
      # @agent déjà défini par set_agent
    end

    # PATCH/PUT /admin/agents/:id
    def update
      if @agent.update(agent_params)
        redirect_to admin_agent_path(@agent), notice: "Les modifications ont été enregistrées avec succès."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /admin/agents/:id
    def destroy
      @agent.destroy
      redirect_to admin_agents_path, notice: "L'agent a été supprimé avec succès."
    end

    private

    def set_agent
      @agent = Agent.find(params[:id])
    end

    def agent_params
      params.require(:agent).permit(
        :last_name, :first_name, :email, :phone,
        :birth_date, :address, :position, :hire_date,
        :status, :department_id
      )
    end
  end
end


class Manager::DashboardController < ApplicationController
  def index
    # Congés en attente
    @conges_en_attente = LeaveRequest.where(status: "pending").includes(:agent)

    # Nombre d'agents actifs
    @agents_actifs = Agent.where(manager_id: current_user.id, status: 'actif').count

    # Présences d'aujourd'hui pour les agents du manager
    today = Date.today
    @attendances_today = Attendance
                          .joins(:agent)
                          .where(agents: { manager_id: current_user.id })
                          .where(check_in: today.beginning_of_day..today.end_of_day)

    # Taux de présence
    total_agents = Agent.where(manager_id: current_user.id).count
    @taux_presence = total_agents.zero? ? 0 : (@attendances_today.count.to_f / total_agents.to_f * 100)

    # Heures cumulées (si tu as une colonne 'hours')
    @heures_cumulees = Attendance
                          .joins(:agent)
                          .where(agents: { manager_id: current_user.id })
                          .sum(:hours)

    # Activités récentes (exemple statique)
    @recent_activities = [
      { icon: "fas fa-user-plus", color: "green", text: "Nouvel agent ajouté" },
      { icon: "fas fa-calendar-check", color: "blue", text: "Congé approuvé" },
      { icon: "fas fa-clock", color: "orange", text: "Pointage enregistré" }
    ]
  end
end

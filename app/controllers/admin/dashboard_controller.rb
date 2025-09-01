# app/controllers/admin/dashboard_controller.rb
require 'ostruct'

class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def index
    @agents_count = Agent.count
    @departments_count = Department.count
    @attendances_today = Attendance.where(check_in: Time.current.beginning_of_day..Time.current.end_of_day).count
    @users_count = User.count

    # Créer un tableau d'activités avec des descriptions
   recent_attendances = Attendance.order(created_at: :desc).limit(5).map do |attendance|
  OpenStruct.new(
    description: "Nouvelle présence de #{attendance.agent&.name || 'un agent'}",
    created_at: attendance.created_at
  )
end


    recent_users = User.order(created_at: :desc).limit(5).map do |user|
      OpenStruct.new(
        description: "Nouvel utilisateur : #{user.email}",
        created_at: user.created_at
      )
    end

    @recent_actions = (recent_attendances + recent_users).sort_by(&:created_at).reverse
  end

  private

  def authorize_admin!
    redirect_to root_path, alert: "Accès refusé" unless current_user.admin?
  end
end

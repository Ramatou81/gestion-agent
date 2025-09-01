
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Redirection après connexion selon le rôle
  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_dashboard_path
    elsif resource.manager?
       manager_dashboard_index_path 
    elsif resource.employee?
      agent_dashboard_path
    else
      root_path
    end
  end

  # Autoriser le champ role pour Devise
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:role])
  end
end

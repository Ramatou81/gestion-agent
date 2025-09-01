Rails.application.routes.draw do
  namespace :manager do
    resources :attendances, only: [:index, :show, :edit, :update]
    resources :leave_requests, only: [:index, :update]
    resources :agents, only: [:index, :show]
    get "dashboard/index"
  end
  # Page d'accueil publique
  root to: 'pages#home'

  # Authentification Devise
  devise_for :users

  # Dashboard admin
  namespace :admin do
     resources :agents
    resources :departments
    resources :attendances
    resources :users
    resources :reports
    resources :settings
    get "dashboard", to: "dashboard#index", as: :dashboard
  end

  # Ressources générales (protégées par login si nécessaire)

end

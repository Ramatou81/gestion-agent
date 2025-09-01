class Agent < ApplicationRecord
  belongs_to :department
  belongs_to :manager, class_name: "Agent", optional: true
  has_many :subordinates, class_name: "Agent", foreign_key: "manager_id"
  has_many :leave_requests, dependent: :destroy
  has_many :attendances, dependent: :destroy

  # Relation pour les départements que cet agent gère
  has_many :managed_departments, class_name: "Department", foreign_key: "manager_id"

  # Nom complet de l'agent
  def full_name
    "#{first_name} #{last_name}".strip
  end

  # Alias pour compatibilité avec les vues
  def name
    full_name
  end

  # Méthode role_name pour la vue
  def role_name
    "Agent"
  end
end

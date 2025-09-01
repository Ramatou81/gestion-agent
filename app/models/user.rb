
# app/models/user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Si l’utilisateur est un agent → il appartient à un département
  belongs_to :department, optional: true

  # Si l’utilisateur est un manager → il gère un département
  has_one :managed_department, class_name: "Department", foreign_key: :manager_id

  # Accès direct aux agents de son département (via le département géré)
  has_many :agents, through: :managed_department, source: :users

  # Congés et pointages
  has_many :leave_requests, foreign_key: "agent_id", dependent: :destroy
  has_many :attendances, foreign_key: "agent_id", dependent: :destroy

  # Rôles
  ROLES = { admin: 0, manager: 1, agent: 2 }.freeze

  validates :role, presence: true, inclusion: { in: ROLES.values }

  def admin?; role == ROLES[:admin]; end
  def manager?; role == ROLES[:manager]; end
  def agent?; role == ROLES[:agent]; end

  scope :admins,   -> { where(role: ROLES[:admin]) }
  scope :managers, -> { where(role: ROLES[:manager]) }
  scope :agents,   -> { where(role: ROLES[:agent]) }

  def name
    [first_name, last_name].compact.join(' ').presence || email
  end

  def role_name
    ROLES.key(role).to_s.capitalize
  end
end

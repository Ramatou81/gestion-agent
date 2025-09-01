class Attendance < ApplicationRecord
belongs_to :agent

  STATUSES = ["présent", "absent", "en retard", "congé"].freeze

  validates :status, presence: true, inclusion: { in: STATUSES }
  validate :check_out_after_check_in

  private

  def agent_name
    agent ? "#{agent.first_name} #{agent.last_name}" : "Non assigné"
  end

  def check_out_after_check_in
    return if check_in.blank? || check_out.blank?

    if check_out < check_in
      errors.add(:check_out, "doit être après l'heure d'arrivée")
    end
  end
end

class LeaveRequest < ApplicationRecord
  belongs_to :agent

  # Définir les statuts comme constante
  STATUSES = {
    pending: 0,
    approved: 1,
    rejected: 2
  }.freeze

  # Validation
  validates :start_date, :end_date, :status, presence: true
  validate :end_date_after_start_date

  # Méthodes d'accès aux statuts
  def status_name
    STATUSES.key(status) # renvoie :pending, :approved, ou :rejected
  end

  def pending?
    status == STATUSES[:pending]
  end

  def approved?
    status == STATUSES[:approved]
  end

  def rejected?
    status == STATUSES[:rejected]
  end

  # Méthodes de mise à jour du statut
  def mark_pending!
    update(status: STATUSES[:pending])
  end

  def mark_approved!
    update(status: STATUSES[:approved])
  end

  def mark_rejected!
    update(status: STATUSES[:rejected])
  end

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after start date")
    end
  end
end

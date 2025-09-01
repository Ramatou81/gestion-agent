class Department < ApplicationRecord
 has_many :agents
  belongs_to :manager, class_name: "User", optional: true

  validates :name, presence: true
end

class WorkspaceMembership < ApplicationRecord
  belongs_to :user
  belongs_to :workspace

  ROLES = %w[owner admin member].freeze

  validates :role, inclusion: { in: ROLES }
  validates :user_id, uniqueness: { scope: :workspace_id }
end
class Project < ApplicationRecord
  belongs_to :workspace
  belongs_to :user
has_many :tasks, dependent: :destroy
  validates :name, presence: true
  validates :status, inclusion: { in: %w[active archived] }

  before_validation :set_default_status, on: :create

  private

  def set_default_status
    self.status ||= "active"
  end
end
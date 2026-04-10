class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user
has_many_attached :attachments
  STATUSES = %w[todo in_progress done].freeze
  PRIORITIES = %w[low medium high].freeze

  validates :title, presence: true
  validates :status, inclusion: { in: STATUSES }
  validates :priority, inclusion: { in: PRIORITIES }

  before_validation :set_defaults, on: :create

  private

  def set_defaults
    self.status ||= "todo"
    self.priority ||= "medium"
  end
end
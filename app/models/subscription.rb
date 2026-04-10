class Subscription < ApplicationRecord
  belongs_to :workspace

  PLANS = %w[free pro business].freeze

  validates :plan, inclusion: { in: PLANS }
  validates :status, inclusion: { in: %w[active canceled past_due] }

  before_validation :set_defaults, on: :create

  def pro?
    plan == "pro"
  end

  def business?
    plan == "business"
  end

  def free?
    plan == "free"
  end

  private

  def set_defaults
    self.plan ||= "free"
    self.status ||= "active"
  end
end
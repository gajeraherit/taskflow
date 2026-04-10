class Workspace < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :workspace_memberships, dependent: :destroy
  has_many :members, through: :workspace_memberships, source: :user
  has_many :projects, dependent: :destroy
  has_one :subscription, dependent: :destroy

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true

  before_validation :generate_slug, on: :create

  def current_plan
    subscription&.plan || "free"
  end

  def can_create_project?
    return true if current_plan == "pro" || current_plan == "business"
    projects.count < 3
  end

  private

  def generate_slug
    self.slug = name.to_s.downcase.gsub(/\s+/, "-") if slug.blank?
  end
end
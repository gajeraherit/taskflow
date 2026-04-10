class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
has_many :workspace_memberships, dependent: :destroy
has_many :workspaces, through: :workspace_memberships
has_many :owned_workspaces, class_name: "Workspace", foreign_key: "owner_id"end


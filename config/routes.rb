Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: "workspaces#index", as: :authenticated_root
  end

  devise_scope :user do
    root to: "devise/sessions#new"
  end

  resources :workspaces, only: [:index, :show, :new, :create] do
    resources :subscriptions, only: [:new, :create]
    resources :projects, only: [:index, :show, :new, :create] do
      resources :tasks, only: [:new, :create, :update, :edit, :destroy]
    end
  end
end
# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    authenticated :user do
      root 'users#profile', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  resources :users, only: %i[show update edit] do
    collection do
      get :profile
    end
  end
  resources :tasks do
    member do
      put :complete
      put :take
    end
  end
end

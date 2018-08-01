# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    authenticated :user do
      root 'users#show', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :users, only: %i[show update edit]
  resources :tasks, only: %i[new create update destroy edit] do
    member do
      put 'complete'
      put 'take'
    end
  end
end

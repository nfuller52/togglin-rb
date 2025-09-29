# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "healthz" => "health#show", as: :rails_health_check, defaults: { format: :json }

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  namespace :api, defaults: { format: :json } do
    namespace :internal do
      resources :organizations, only: [:create, :index]
      resource :session, only: [:create, :destroy, :show]
    end
  end

  # Defines the root path route ("/")
  root "pages#home"
  get "*path", to: "pages#home", constraints: ->(request) do
    !request.xhr? && request.format.html?
  end
end

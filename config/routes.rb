Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # resources :events
  resources :events do
    collection do
      get :export_csv
    end
  end
  root "events#index"
  resources :events, only: [ :index, :show ] do
    resources :registrations, only: [ :create ]
  end
  resources :registrations, only: [ :index ], as: :all_registrations
  resources :registrations, only: [ :destroy ], as: :cancel_registration
  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  # Defines the root path route ("/")
  # root "posts#index"
  resources :users, only: [ :new, :create ]
end

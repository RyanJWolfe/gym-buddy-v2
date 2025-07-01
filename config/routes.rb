Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: "dashboard#index", as: :authenticated_root
  end

  root to: "static_pages#home"

  resources :workouts do
    resources :exercise_logs, except: [:index, :show] do
      resources :exercise_sets, except: [:index, :show]
    end

    member do
      post "duplicate", to: "workouts#create_duplicate"
    end
  end

  resources :routines do
    resources :routine_exercises, except: [:index, :show] do
      resources :exercises, only: [:new, :create]
    end
  end

  resources :exercises

  get "dashboard", to: "dashboard#index"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  # Add these routes
  resource :profile, only: [:show, :edit, :update]

  namespace :exports do
    get :workouts
  end
end

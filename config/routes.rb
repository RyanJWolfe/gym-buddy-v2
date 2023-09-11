Rails.application.routes.draw do
  resources :users do
    resources :workouts do
      resources :exercises do
        resources :exercise_sets
      end
    end
  end

  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
end

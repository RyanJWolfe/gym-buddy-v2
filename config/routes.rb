Rails.application.routes.draw do
  devise_for :users

  resources :users do
    resources :workouts do
      post :add_exercise
      delete :remove_exercise
      resources :exercise_sets
    end

    resources :exercises
  end

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
end

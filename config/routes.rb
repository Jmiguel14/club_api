Rails.application.routes.draw do
  defaults format: :json do
    devise_for :users,
               skip: [ :sessions, :registrations ]

    devise_scope :user do
      post "signup", to: "users/registrations#create"
      post "login", to: "users/sessions#create"
      delete "logout", to: "users/sessions#destroy"
      get "me", to: "users/sessions#show", as: :user_profile
    end

    resources :apartments
    resources :products
    resources :invoices
    resources :invoice_details
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end

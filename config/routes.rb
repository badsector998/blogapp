Rails.application.routes.draw do
  devise_for :admins
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # get "articles", to: "articles#index"
  # get "articles/:id", to: "articles#show"
  # can be replaced by resources :articles to accommodate CUD operation. No need to specify each endpoint

  resources :articles do
    resources :comments
    get 'page/:page', action: :index, on: :collection
  end

  # Defines the root path route ("/")
  root "articles#index"
end

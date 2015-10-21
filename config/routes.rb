Rails.application.routes.draw do
  resources :airports, only: :index
  get 'airports/distance', to: "airports#distance"
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  
  resources :measures
  resources :unit_of_measurements
  resources :metrics
  
end

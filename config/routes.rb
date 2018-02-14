Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'measures#new'

  resources :unit_of_measurements
  resources :measures
end

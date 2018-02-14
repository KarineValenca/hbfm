Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'unit_of_measurements#new'

  resources :unit_of_measurements
end

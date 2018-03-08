Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  
  resources :measures do
  	collection do
  		post 'sort'
  	end
  end
  resources :unit_of_measurements
  resources :metrics
  
end

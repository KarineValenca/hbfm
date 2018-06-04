Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  
  resources :measures do
  	collection do
  		post 'sort'
      post 'update_operator'
  	end
  end
  resources :unit_of_measurements
  resources :metrics
  
  resources :final_measures do
    collection do
      post 'finalize_measure'
      post '/:id/finalize_measure', to: 'final_measures#edit'
      post 'import/:id(.:format)', to: "final_measures#import",  as: :import

    end

  end
  
end

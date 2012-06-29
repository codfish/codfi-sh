Codly::Application.routes.draw do

  root :to => 'urls#index'
  
  match "/urls/popular" => 'urls#index', :defaults => { :popular => true }, :as => :popular
  resources :urls
  
  # devise, user routes
  devise_for :users
  resources :users, :only => [:show]
	
	# nested route for user urls	(/users/3/urls => should give you urls#index in the context of the current user)
	resources :users do
	  resources :urls, only: [:index]
	end
  
  # this match only works if it's below all other shit, or else /urls will match it for instance
  match '/:short_url' => 'urls#redirect'

  # See how all your routes lay out with "rake routes"
end

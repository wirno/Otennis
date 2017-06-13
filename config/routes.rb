Rails.application.routes.draw do
	devise_for :users, controllers: { registrations: 'users/registrations' }

	root to: 'home#index'
	get 'home', to:'home#index', as: 'home'

	get '/discover' => 'static#discover'
  get '/search' => 'static#search'


	get 'indexer/index'
  	get 'indexer/reindex'

  	get 'matchmaking', to: 'users#matchmaking', as:'matchmaking'
  	get 'profile', to: 'users#profile'
	get 'profile/:id', to: 'users#show', as:'find_profile'

end

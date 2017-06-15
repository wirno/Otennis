Rails.application.routes.draw do
  	devise_for :clubs, controllers: { registrations: 'clubs/registrations', sessions: 'clubs/sessions' }
	devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }

	root to: 'home#index'
	get 'home', to:'home#index', as: 'home'

	get '/discover' => 'static#discover'
  	get '/search' => 'static#search'

	get 'indexer/index'
  	get 'indexer/reindex'

  	get 'matchmaking', to: 'users#matchmaking', as:'matchmaking'
  	get 'users/profile', to: 'users#profile'
	get 'users/profile/:id', to: 'users#show', as:'users_find_profile'
	
	get 'matchmaking/settings', to: 'users#settings'
	post 'matchmaking/parameters', to: 'users#parameters'
	get 'matchmaking/parameters', to: 'users#redirsettings'

	get 'clubs/profile', to: 'clubs#profile'
	get 'clubs/profile/:id', to: 'clubs#show', as:'clubs_find_profile'

	get 'clubs/search/settings', to: 'clubs#settings'
	post 'clubs.search', to: 'clubs#search'

	post 'clubs/profile/create/terrains', to: 'clubs#createterrains'

end

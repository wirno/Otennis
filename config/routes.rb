Rails.application.routes.draw do
	devise_for :users, controllers: { registrations: 'users/registrations' }

	root to: 'home#index'
	get 'home', to:'home#index', as: 'home'

	get 'indexer/index'
  	get 'indexer/reindex'

  	get 'matchmaking', to: 'users#matchmaking', as:'matchmaking'
end

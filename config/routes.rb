Rails.application.routes.draw do
devise_for :users, controllers: { registrations: 'users/registrations' }

	root to: 'home#index'
	get 'home', to:'home#index', as: 'home'
end

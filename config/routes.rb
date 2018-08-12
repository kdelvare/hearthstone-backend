Rails.application.routes.draw do
	resources :cardclasses
	resources :cardsets
	resources :cards
	resources :collections
	resources :users
end

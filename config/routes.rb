Rails.application.routes.draw do
	resources :cardclasses
	resources :cardsets
	resources :rarities
	resources :cards
	resources :collections
	resources :users
	resources :decks
	resources :deckcards
end

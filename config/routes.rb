Rails.application.routes.draw do
	jsonapi_resources :cardclasses
	jsonapi_resources :cardsets
	jsonapi_resources :rarities
	jsonapi_resources :cards
	jsonapi_resources :collections
	jsonapi_resources :users
	jsonapi_resources :decks
	jsonapi_resources :deckcards
	jsonapi_resources :deckgroups
	jsonapi_resources :wanteddecks
	resources :stats
end

Rails.application.routes.draw do
	use_doorkeeper
	jsonapi_resources :cardclasses
	jsonapi_resources :years
	jsonapi_resources :cardsets
	jsonapi_resources :rarities
	jsonapi_resources :types
	jsonapi_resources :cards
	jsonapi_resources :collections
	jsonapi_resources :users
	jsonapi_resources :decks
	jsonapi_resources :deckcards
	jsonapi_resources :deckgroups
	jsonapi_resources :wanteddecks
	jsonapi_resources :wantedcards
	jsonapi_resources :deckstats
	jsonapi_resources :pitycounters
	resources :stats
	get 'current_user', to: 'users#me'
end

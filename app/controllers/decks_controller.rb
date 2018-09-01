class DecksController < ApplicationController
	def index
		render json: Deck.all, :include => [:cardclass]
	end

	def show
		render json: Deck.find(params[:id])
	end

	def create
		@deck = Deck.create(deck_params)
		render json: @deck, status: :created
	end

	def update
		@deck = Deck.find(params[:id])
		@deck.update(deck_params)
		head :no_content
	end

	private

	def deck_params
		params[:cardclass_id] = params[:cardclass]
		params.permit(:name, :url, :cardclass_id)
	end
end

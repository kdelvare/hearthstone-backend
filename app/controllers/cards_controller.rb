class CardsController < ApplicationController
	def index
		@cards = Card.all
		@cards = @cards.cardclass(params[:class]) if params[:class].present?
		@cards = @cards.limit(10)
		render json: @cards
	end
end

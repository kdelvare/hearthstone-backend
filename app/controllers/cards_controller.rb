class CardsController < ApplicationController
	def index
		@cards = Card.where.not(type: 3)  # filter Hero cards
		@cards = @cards.cardclass(params[:class]) if params[:class].present?
		@cards = @cards.limit(14)
		render json: @cards
	end
end

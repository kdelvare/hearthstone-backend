class CardsController < ApplicationController
	def index
		@cards = Card.where.not(type: 3)  # filter Hero cards
		@cards = @cards.cardclass(params[:class]) if params[:class].present?
		@cards = @cards.cost(params[:cost]) if params[:cost].present?
		@cards = @cards.cardset(params[:cardset]) if params[:cardset].present?
		@cards = @cards.limit(14)
		render json: @cards
	end
end

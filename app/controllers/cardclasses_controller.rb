class CardclassesController < ApplicationController
	def index
		@cardclasses = Cardclass.all
		@cardclasses = @cardclasses.where(collectible: true) if params[:collectible] == "true"
		@cardclasses = @cardclasses.where(card: params[:card]) if params[:card].present?
		render json: @cardclasses
	end

	def show
		@cardclass = Cardclass.find(params[:id])
		render json: @cardclass
	end
end

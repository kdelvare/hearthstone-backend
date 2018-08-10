class CardclassesController < ApplicationController
	def index
		if params[:collectible] == "true"
			render json: Cardclass.where(collectible: true)
		else
			render json: Cardclass.all
		end
	end
end

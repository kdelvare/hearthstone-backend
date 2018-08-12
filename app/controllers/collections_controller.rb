class CollectionsController < ApplicationController
	def create
		@collection = Collection.create!(collection_params)
		render json: @collection, status: :created
	end

	def update
		@collection = Collection.find(params[:id])
		@collection.update(collection_params)
		head :no_content
	end

	def destroy
		@collection = Collection.find(params[:id])
		@collection.destroy
		head :no_content
	end

	private

	def collection_params
		logger.info "collection params: #{params}"
		params.permit(:card_id, :user_id, :number)
	end
end

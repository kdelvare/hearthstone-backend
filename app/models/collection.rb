class Collection < ActiveRecord::Base
	belongs_to :user
	belongs_to :card

	def create
		respond_with Collection.create(collection_params)
	end

	private

	def user_params
		params.require(:user_id, :card_id).permit(:number)
	end
end

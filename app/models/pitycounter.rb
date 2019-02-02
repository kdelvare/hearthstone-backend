class Pitycounter < ActiveRecord::Base
	belongs_to :user
	belongs_to :cardset
	belongs_to :rarity

	def create
		respond_with Pitycounter.create(pitycounter_params)
	end

	private

	def pitycounter_params
		params.require(:user_id, :cardset_id, :rarity_id).permit(:number)
	end
end

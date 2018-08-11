class Cardset < ActiveRecord::Base
	self.primary_key = 'hs_id'
	has_many :cards

	def create
		respond_with Cardset.create(cardset_params)
	end

	private

	def cardset_params
		params.require(:cardset).permit(:hs_id, :name)
	end
end

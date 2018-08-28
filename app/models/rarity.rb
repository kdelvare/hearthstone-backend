class Rarity < ActiveRecord::Base
	self.primary_key = 'hs_id'
	has_many :cards

	def create
		respond_with Rarity.create(rarity_params)
	end

	def type
		self.class.name
	end

	def as_json(options = {})
		super(options.merge({ :methods => :type }))
	end

	private

	def rarity_params
		params.require(:rarity).permit(:hs_id, :name)
	end
end

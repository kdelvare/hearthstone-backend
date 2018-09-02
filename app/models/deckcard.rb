class Deckcard < ActiveRecord::Base
	belongs_to :deck
	belongs_to :card

	def create
		respond_with Deckcard.create(deckcard_params)
	end

	def type
		self.class.name
	end

	def as_json(options = {})
		super(options.merge({ :methods => :type }))
	end

	private

	def deckcard_params
		params.require(:deck_id, :card_id).permit(:number)
	end
end

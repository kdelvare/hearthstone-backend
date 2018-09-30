class Card < ActiveRecord::Base
	self.primary_key = 'hs_id'
	belongs_to :cardset
	belongs_to :cardclass
	belongs_to :type
	belongs_to :rarity
	has_many :collections
	has_many :users, through: :collections
	has_many :deckcards
	has_many :decks, through: :deckcards

	def create
		respond_with Card.create(card_params)
	end

	#default_scope { joins("LEFT JOIN collections ON collections.card_id = cards.hs_id") }

	private

	def card_params
		params.require(:card).permit(:hs_id, :hs_card_id, :name, :name_fr, :cardtext, :cardtext_fr, :flavor, :flavor_fr, :artist, :cost, :health, :atk)
	end
end

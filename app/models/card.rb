class Card < ActiveRecord::Base
	self.primary_key = 'hs_id'
	belongs_to :cardset
	belongs_to :cardclass
	belongs_to :type
	belongs_to :rarity

	def create
		respond_with Card.create(card_params)
	end

	scope :cardclass, -> (cardclass_id) { where cardclass_id: cardclass_id }
	scope :cost, -> (cost) { where cost: cost }
	scope :cardset, -> (cardset_id) { where cardset_id: cardset_id }

	private

	def card_params
		params.require(:card).permit(:hs_id, :hs_card_id, :name, :name_fr, :cardtext, :cardtext_fr, :flavor, :flavor_fr, :artist, :cost, :health, :atk)
	end
end

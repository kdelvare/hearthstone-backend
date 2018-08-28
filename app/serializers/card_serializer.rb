class CardSerializer < ActiveModel::Serializer
	attributes :hs_id, :hs_card_id, :name, :name_fr, :cardtext, :cardtext_fr, :flavor, :flavor_fr, :artist, :cost, :health, :atk
	belongs_to :cardset
	belongs_to :rarity
	has_many :collections
end

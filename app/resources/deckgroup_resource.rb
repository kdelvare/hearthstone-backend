class DeckgroupResource < JSONAPI::Resource
	attributes :name, :url

	belongs_to :cardset
	has_many :decks
end

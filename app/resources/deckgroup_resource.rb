class DeckgroupResource < JSONAPI::Resource
	attributes :name, :url

	has_many :decks
end

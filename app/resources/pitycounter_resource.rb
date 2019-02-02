class PitycounterResource < JSONAPI::Resource
	attributes :number

	belongs_to :user
	belongs_to :cardset
	belongs_to :rarity

	filters :user, :cardset

	def self.sortable_fields(context)
		super + [:"rarity_id"]
	end
end

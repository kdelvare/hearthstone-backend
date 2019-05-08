class ArenarewardResource < JSONAPI::Resource
	attributes :gold, :dust, :golden

	belongs_to :arena
	belongs_to :cardset
	belongs_to :card

	filters :arena
end

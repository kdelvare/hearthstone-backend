class ArenamatchResource < JSONAPI::Resource
	attributes :won

	belongs_to :arena
	belongs_to :cardclass

	filters :arena, :cardclass
end

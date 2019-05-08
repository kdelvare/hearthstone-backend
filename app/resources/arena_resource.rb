class ArenaResource < JSONAPI::Resource
	attributes :date, :archetype, :score, :done, :win

	belongs_to :cardclass
	belongs_to :user
	has_many :arenamatches
	has_many :arenarewards

	filters :cardclass, :user
end

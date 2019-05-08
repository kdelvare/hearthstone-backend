class Arenareward < ActiveRecord::Base
	belongs_to :arena
	belongs_to :cardset, optional: true
	belongs_to :card, optional: true
end

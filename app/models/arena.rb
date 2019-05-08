class Arena < ActiveRecord::Base
	belongs_to :cardclass
	belongs_to :user
	has_many :arenamatches
	has_many :arenarewards
end

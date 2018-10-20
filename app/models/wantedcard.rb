class Wantedcard < ActiveRecord::Base
	belongs_to :user
	belongs_to :card
	belongs_to :wanteddeck
end

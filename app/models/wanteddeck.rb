class Wanteddeck < ActiveRecord::Base
	belongs_to :user
	belongs_to :deck
	has_many :wantedcards, dependent: :delete_all
end

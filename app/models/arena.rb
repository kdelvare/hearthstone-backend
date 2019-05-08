class Arena < ActiveRecord::Base
	belongs_to :cardclass
	belongs_to :user
end

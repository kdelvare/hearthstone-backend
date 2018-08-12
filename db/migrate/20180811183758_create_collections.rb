class CreateCollections < ActiveRecord::Migration[5.1]
	def change
		create_table :collections do |t|
			t.integer :user_id
			t.integer :card_id
			t.integer :number
		end
	end
end

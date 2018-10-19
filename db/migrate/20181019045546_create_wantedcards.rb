class CreateWantedcards < ActiveRecord::Migration[5.1]
	def change
		create_table :wantedcards do |t|
			t.integer :user_id
			t.integer :card_id
			t.integer :wanteddeck_id
			t.integer :number
		end
	end
end

class CreateDeckcards < ActiveRecord::Migration[5.1]
	def change
		create_table :deckcards do |t|
			t.integer :deck_id
			t.integer :card_id
			t.integer :number
		end
	end
end

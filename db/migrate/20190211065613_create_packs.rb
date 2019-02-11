class CreatePacks < ActiveRecord::Migration[5.1]
	def change
		create_table :packs do |t|
			t.integer :user_id
			t.integer :cardset_id
			t.integer :number
		end
	end
end

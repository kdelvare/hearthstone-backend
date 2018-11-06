class AddGoldenToCollections < ActiveRecord::Migration[5.1]
	def change
		change_table :collections do |t|
			t.integer :golden
		end
	end
end

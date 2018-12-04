class CreateYear < ActiveRecord::Migration[5.1]
	def change
		create_table :years do |t|
			t.string :name
			t.string :name_fr
			t.boolean :standard
		end

		change_table :cardsets do |t|
			t.integer :year_id
		end
	end
end

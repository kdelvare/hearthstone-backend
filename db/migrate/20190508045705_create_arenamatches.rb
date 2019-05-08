class CreateArenamatches < ActiveRecord::Migration[5.1]
  def change
	create_table :arenamatches do |t|
		t.integer :arena_id
		t.integer :cardclass_id
		t.boolean :won
    end
  end
end

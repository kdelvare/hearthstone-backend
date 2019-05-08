class CreateArenas < ActiveRecord::Migration[5.1]
  def change
	create_table :arenas do |t|
		t.integer :user_id
		t.date :date
		t.integer :cardclass_id
		t.string :archetype
		t.float :score
		t.boolean :done
		t.integer :win
    end
  end
end

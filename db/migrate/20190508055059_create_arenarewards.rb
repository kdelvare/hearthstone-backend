class CreateArenarewards < ActiveRecord::Migration[5.1]
  def change
    create_table :arenarewards do |t|
		t.integer :arena_id
		t.integer :gold
		t.integer :dust
		t.integer :cardset_id
		t.integer :card_id
		t.boolean :golden
    end
  end
end

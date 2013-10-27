class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :criteria_id
      t.integer :scorecard_id
      t.integer :score

      t.timestamps
    end
    
    add_index :scores, :criteria_id
    add_index :scores, :scorecard_id
  end
end

class CreateScorecards < ActiveRecord::Migration
  def change
    create_table :scorecards do |t|
      t.string :url
      t.integer :grader_id
      t.integer :gradee_id
      t.timestamps
    end
    
    add_index :scorecards, :grader_id
    add_index :scorecards, :gradee_id
    add_index :scorecards, [:grader_id, :gradee_id]
  end
end

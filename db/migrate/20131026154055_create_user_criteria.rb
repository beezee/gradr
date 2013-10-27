class CreateUserCriteria < ActiveRecord::Migration
  def change
    create_table :user_criteria do |t|
      t.integer :criteria_id
      t.integer :user_id

      t.timestamps
    end
    add_index :user_criteria, :criteria_id
    add_index :user_criteria, :user_id
  end
end

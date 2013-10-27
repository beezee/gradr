class RenameCriteriaIdToCriteriumId < ActiveRecord::Migration
  def change
    rename_column :scores, :criteria_id, :criterium_id
    rename_column :user_criteria, :criteria_id, :criterium_id
  end
end

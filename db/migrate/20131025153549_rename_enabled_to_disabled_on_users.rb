class RenameEnabledToDisabledOnUsers < ActiveRecord::Migration
  def up
    rename_column :users, :enabled, :disabled
  end

  def down
    rename_column :users, :disabled, :enabled
  end
end

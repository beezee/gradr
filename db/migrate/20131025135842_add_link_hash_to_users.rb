class AddLinkHashToUsers < ActiveRecord::Migration
  def change
    add_column :users, :link_hash, :string
  end
end

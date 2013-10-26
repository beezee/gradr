class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :salt
      t.string :slug
      t.boolean :enabled

      t.timestamps
    end
  end
end

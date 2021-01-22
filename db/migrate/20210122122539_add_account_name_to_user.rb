class AddAccountNameToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :account, :string, null: false, unique: true
  end
end

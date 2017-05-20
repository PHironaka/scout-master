class AddHometownToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :hometown, :string
  end
end

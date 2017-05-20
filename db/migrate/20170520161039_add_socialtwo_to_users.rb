class AddSocialtwoToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :socialtwo, :string
  end
end

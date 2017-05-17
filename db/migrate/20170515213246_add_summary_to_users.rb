class AddSummaryToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :summary, :string
  end
end

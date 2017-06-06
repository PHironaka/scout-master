class AddPortfolioToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :portfolio, :string
  end
end

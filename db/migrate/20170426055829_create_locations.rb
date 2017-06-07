class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :title
      t.string :body
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end

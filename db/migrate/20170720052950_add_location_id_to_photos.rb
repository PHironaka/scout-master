class AddLocationIdToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :location_id, :integer
  end
end

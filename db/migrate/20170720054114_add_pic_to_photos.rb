class AddPicToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :pic, :string
  end
end

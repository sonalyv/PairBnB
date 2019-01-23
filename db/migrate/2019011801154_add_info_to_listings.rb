class AddInfoToListings < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :bedrooms, :integer
    add_column :listings, :bathrooms, :integer
    add_column :listings, :price, :integer
  end
end

class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.string :name
      t.text :description
      t.string :address
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :country
      t.string :property_type
      t.boolean :category

      t.timestamps
    end
  end
end

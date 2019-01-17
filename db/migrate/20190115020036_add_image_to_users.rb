class AddImageToUsers < ActiveRecord::Migration[5.2]
  def change
  attr_accessible :gallery_id, :name, :image
  end
end

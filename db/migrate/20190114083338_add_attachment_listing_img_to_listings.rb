class AddAttachmentListingImgToListings < ActiveRecord::Migration[5.2]
  def self.up
    change_table :listings do |t|
      t.attachment :listing_img
    end
  end

  def self.down
    remove_attachment :listings, :listing_img
  end
end

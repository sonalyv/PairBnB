class Listing < ApplicationRecord
	belongs_to :user
	self.per_page = 10
	has_attached_file :listing_img, styles: { listing_index: "250x250>", listing_show: "400x400>" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :listing_img, content_type: /\Aimage\/.*\z/
  	has_many :reservations

end

WillPaginate.per_page = 10

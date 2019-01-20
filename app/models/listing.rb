class Listing < ApplicationRecord
	belongs_to :user
	self.per_page = 10
	has_attached_file :listing_img, styles: { listing_index: "700x700>", listing_show: "700x700>" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :listing_img, content_type: /\Aimage\/.*\z/
  	has_many :reservations, dependent: :delete_all

end

WillPaginate.per_page = 9

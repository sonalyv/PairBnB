class Listing < ApplicationRecord
	belongs_to :user
	self.per_page = 9
	has_attached_file :listing_img, styles: { listing_index: "700x700>", listing_show: "700x700>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :listing_img, content_type: /\Aimage\/.*\z/
  has_many :reservations, dependent: :delete_all

  WillPaginate.per_page = 9
  
  require 'pg_search'
  include PgSearch
  multisearchable :against => [ :name, :description, :city, :country ]

  
  scope :city, -> (city) { where( "city ILIKE :city", city: "%#{city}%" )}
  scope :price, -> (price) { where ( "price < ?" " #{price} ")}
  scope :bedrooms, -> (bedrooms) { where ( "bedrooms >= ?" " #{bedrooms}" )}
  scope :bathrooms, -> (bathrooms) { where ("bathrooms >= ?" " #{bathrooms}")} 




def self.search(search)
    where(['city iLIKE ?', "%#{search}%"])
end 

  def self.search_cities(query)
      where("city ILIKE :city", city: "%#{query}%") do |record|
        record.city
      end
    end
    
  def host
      if self.user_id == nil
        "Mystery house!"
      else
        User.find(self.user_id).first_name
      end
    end

# def self.search_by(search_term)
# 	where("LOWER(name) LIKE :search_term", 
# 	search_term: "%#{search_term.downcase}%")
# end

# def self.between_range(search_pricen_term, search_pricex_term)
# 	scope :between_range, -> (min,max){
# 		where("price >= ? AND price <= ?", min,max)
# 	}

# end



end

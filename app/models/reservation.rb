class Reservation < ApplicationRecord
		belongs_to :user
		belongs_to :listing
		# validates :start_date, :end_date, :overlap => {:scope => "listing_id"}
end

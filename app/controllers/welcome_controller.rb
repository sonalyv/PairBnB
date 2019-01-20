class WelcomeController < ApplicationController

def index

	@listing1 = Listing.find(18)
	@listing2 = Listing.find(32)
	@listing3 = Listing.find(33)

end

end

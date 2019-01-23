class ListingsController < ApplicationController
  before_action :find_listing, only: [:show, :edit, :update, :destroy, :verified]


def index
  if params[:search]
    @listings = Listing.search(params[:search])
    @listings = Listing.search(params[:search]).paginate(page: params[:page])
  else
    @listings = Listing.paginate(:page => params[:page])
   end 
end

# @listings = Listing.find(params[:id])
# @listings = Listing.paginate(:page => params[:page])
# @listings = Listing.paginate(:page => params[:pßage])
  # ## perform a paginated query:
  # @listing = Listing.paginate(:page => params[:page])
  # @listings = Listing.all.order("created_at DESC")

def new 
  @listing = current_user.listings.build
end 

def show
  authorize! :update, @listing 
end

def create
  @listing = current_user.listings.build(listing_params)
    if @listing.save
      redirect_to '/listings'
    else
      flash[:message] = "Listing was not created"
      render 'new'
    end
end

def edit 
  authorize! :update, @listing 
end 

def update 
  if @listing.update(listing_params)
    redirect_to listing_path(@listing)
  else 
    render "edit"
  end 
end

def destroy 
  @listing.destroy
  redirect_to '/listings'
end 


def verified 
  if current_user.admin?
    @listing.verify = true
    @listing.save
  else
    flash[:message] = "Sorry, you are not authorized"
  end 
  redirect_to listing_path(@listing)
end 


private 

  def listing_params
    params.require(:listing).permit(:name, :description, :address, :city, :state, :zipcode, :country, :property_type, :category, :listing_img, :verify, :price, :bedrooms, :bathrooms)
  end

  def find_listing
    @listing = Listing.find(params[:id])
  end

end 
class ReservationsController < ApplicationController


def index
  @user_reservation = Reservation.where(user_id: current_user.id) 
end

def new 
  @reservation = Reservation.new
  @listing = Listing.find(params[:listing_id])
end 

def show
    @listing = Listing.find(params[:listing_id])
    @reservation = Reservation.find(params[:id])
    @reservation.listing_id = @listing.id
end

def create
  @listing = Listing.find(params[:reservation][:listing_id])
  @reservation = Reservation.new(reservation_params)
  @reservation.listing_id = @listing.id
  @reservation.user_id = current_user.id
    if @reservation.save
       # ReservationMailer.booking_email(@reservation, current_user).deliver_now
       ReservationJob.perform_later(@reservation, current_user)
      redirect_to listing_reservation_path(listing_id: @listing.id , id: @reservation.id)
    else
      flash[:message] = "Reservation was not saved"
      render 'new'
    end
end

def edit 
end 

def update 
  if @reservation.update(reservation_params)
    redirect_to reservation_path(@reservation)
  else 
    render "edit"
  end 
end

def destroy 
  @reservation = Reservation.find(params[:id])
  @reservation.destroy
  redirect_to '/reservations'
end 


private 

  def reservation_params
    params.require(:reservation).permit(:listing_id, :user_id, :start_date, :end_date, :confirmed)
  end


end 
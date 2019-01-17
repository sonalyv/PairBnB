class ReservationMailer < ApplicationMailer
  
  def booking_email(reservation, user)
  	 @greeting = "Hi"
  	 @user = user
     @reservation = reservation
     mail(to: @user.email, subject: 'You are confirmed')
  end
end

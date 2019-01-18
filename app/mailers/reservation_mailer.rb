class ReservationMailer < ApplicationMailer
  
  def booking_email(reservation, user)
  	 @greeting = "Hi"
  	 @user = user

  	 @url = "http://localhost:3000/users/#{user.id}"
     @reservation = reservation
     mail(to: @user.email, subject: 'You are confirmed')
  end
end

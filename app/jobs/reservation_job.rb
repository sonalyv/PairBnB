class ReservationJob < ApplicationJob
  queue_as :default

  def perform(reservation, user)
     @reservation = reservation
     @user = user
     ReservationMailer.booking_email(reservation, user).deliver_now
  end
end

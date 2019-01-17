class PaymentsController < ApplicationController

def new
  @client_token = Braintree::ClientToken.generate
end

def checkout
  nonce_from_the_client = params[:checkout_form][:payment_method_nonce]
  result = Braintree::Transaction.sale(
   :amount => "10.00", #this is currently hardcoded
   :payment_method_nonce => nonce_from_the_client,
   :options => {
      :submit_for_settlement => true
    }
   )

  if result.success?
    @reservation.confirmed = true
    @reservation.save
    redirect_to new_user_reservation_payment_path
    flash[:success] = "You are all confirmed!!"
  else
    redirect_to new_user_reservation_payment_path
    flash[:alert] = "Your payment did not go through, please try again"
  end
end


end

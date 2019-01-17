class ApplicationController < ActionController::Base
  include Clearance::Controller
  rescue_from CanCan::AccessDenied do |exception|
   redirect_to listings_url, :alert => exception.message
  end 

end

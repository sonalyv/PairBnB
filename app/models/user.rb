class User < ApplicationRecord
  include Clearance::User
  has_many :authentications, dependent: :destroy
  has_many :listings
  has_many :reservations
  has_attached_file :avatar, styles: {avatar_show: "300x300>", avatar_thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  


  # devise :omniauthable, omniauth_providers: [:google_oauth2]


 def self.create_with_auth_and_hash(authentication, auth_hash)
   user = self.create!(
     first_name: auth_hash["info"]["name"],
     last_name: auth_hash["info"]["name"],
     email: auth_hash["info"]["email"],
     password: SecureRandom.hex(10)
   )
   user.authentications << authentication
   return user
 end

 # grab google to access google for user data
 def google_token
   x = self.authentications.find_by(provider: 'google_oauth2')
   return x.token unless x.nil?
 end





# class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
#   def google_oauth2
#       # You need to implement the method below in your model (e.g. app/models/user.rb)
#       @user = User.from_omniauth(request.env['omniauth.auth'])

#       if @user.persisted?
#         flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
#         sign_in_and_redirect @user, event: :authentication
#       else
#         session['devise.google_data'] = request.env['omniauth.auth'].except(:extra) # Removing extra as it can overflow some session stores
#         redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
#       end
#   end
# end 

# def self.from_omniauth(access_token)
#     data = access_token.info
#     user = User.where(email: data['email']).first

#     # Uncomment the section below if you want users to be created if they don't exist
#     # unless user
#     #     user = User.create(name: data['name'],
#     #        email: data['email'],
#     #        password: Devise.friendly_token[0,20]
#     #     )
#     # end
#     user
# end

# end
end

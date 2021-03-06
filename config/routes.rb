Rails.application.routes.draw do

  get 'braintree/new'
  root to: "welcome#index"

  get "/redirect_to_profile", to: "users#redirect_from_login"
  get '/listings/:id/verified' => "listings#verified", as: "verified_listing"

  resources :reservations
 
  resources :listings do 
     resources :reservations 
  end

  resources :users do 
     resources :reservations do
      resource :payment
  end
  end

  resources :search, controller: "search", only: [:index]

  resources :passwords, controller: "clearance/passwords", only: [:create, :new] 
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  # <%= link_to 'edit password', edit_user_password_path %>


  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"

  

  post "/users/:user_id/reservations/:reservation_id/checkout" => "payments#checkout", as: "payments_checkout"

  post "/users/:user_id/reservations/:reservation_id/confirmed" => "reservations#index", as: "reservations_confirmed"


   post '/search' => 'search#search'
  # constraints Clearance::Constraints::SignedIn.new { |user| user.admin? } do
  #   root to: "admin/dashboards#show", as: :admin_root
  # end

  # constraints Clearance::Constraints::SignedIn.new do
  #   root to: "dashboards#show", as: :signed_in_root
  # end

  # constraints Clearance::Constraints::SignedOut.new do
  #   root to: "marketing#index"
  # end

# devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }



end

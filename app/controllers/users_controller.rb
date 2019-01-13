class UsersController < Clearance::UsersController

def redirect_from_login
  redirect_to user_path(current_user)
end



def new 
  @user = User.new
end 

def show
  @user = User.find(params[:id])
end


  def create
    user = User.new(user_params)
    if user.save
      sign_in(user)
      redirect_to user_path(user.id)
  else
    flash[:message] = "User was not created"
    redirect_to sign_up_path
  end
end

private 

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end


end

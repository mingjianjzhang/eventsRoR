class UsersController < ApplicationController
  def dashboard
  	@user = User.find(session[:user_id])
  end

  def edit
  	@user = User.find(params[:id])
  end 

  def create
  	params.permit!
  	user = User.new(params[:user])
  	if user.save 
  	  session[:user_id] = user.id 
  	  redirect_to "/events"
  	else
  	  flash[:errors] = user.errors.full_messages
  	  redirect_to "/"
  	end
  end
  def update
    params.permit!
    User.find(params[:id]).update(params[:user])
    redirect_to "/user/#{session[:user_id]}"
  end
  # private
  # def user_params
  # 	params.require(:user).permit(:first_name, :last_name, :email, :city, :state)
  # end
end

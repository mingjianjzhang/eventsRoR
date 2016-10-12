class SessionsController < ApplicationController
  def index

  end
  def login
  	params.permit!
  	user = User.find_by(email: params[:email])
  	if user
  	  if user.authenticate(params[:password])
  	  	session[:user_id] = user.id
  	  	redirect_to "/events"
  	  else
  	    flash[:bad_password] = "Invalid password"
  	    redirect_to "/"
  	   end
  	else 
  	  flash[:no_user] = "As far as we're concerned, you don't exist. Please register to the left"
  	  redirect_to "/"
  	end
  end
  def logout
  	reset_session
  	redirect_to "/"
  end
end
 
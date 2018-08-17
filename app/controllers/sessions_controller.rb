class SessionsController < ApplicationController
	
  def new
  end
  def create
  	user = User.find_by(email: params[:session][:email].downcase)
   # if user ==nil
      # Log the user in and redirect to the user's show page.
     # flash.now[:danger] = "Invalid email address"
      
    if user && user.authenticate(params[:session][:password])
  	  log_in user
  	  params[:session][:remember_me] ? remember(user) : forget(user)
  	  
      redirect_to user
    else
      # Create an error message.
      flash.now[:danger] = "Password didn't match"
  	  render 'new'
  	end
  end
  def destroy
    log_out 
    redirect_to root_url
  
  end
  def profile
  	@user = User.find_by(id: session[:user_id])
  end
  
end

class UserSessionsController < ApplicationController

  def new
  end

  def create
    user = User.where(email: params[:email]).first
    if user && user.authenticate(params[:password])
      # sets a cookie / stores a session
      session[:user_id] = user.id
       flash[:notice] = "You are now logged in!"
      redirect_to posts_path
    else
       flash[:alert] = "The email or password you entered is incorrect. Please try again."
      redirect_to login_path
    end
  end

  def destroy
    session.delete :user_id
    redirect_to "/"
  end

end

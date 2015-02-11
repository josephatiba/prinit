class SessionsController < ApplicationController

    def new
  end

  def create
    user = User.where(email: params[:email]).first
    if user && user.authenticate(params[:password])
      # sets a cookie / stores a session
      session[:user_id] = user.id
      redirect_to posts_path
    else
      redirect_to login_path
    end
  end

  def destroy
    session.delete :user_id
    redirect_to "/"
  end
end

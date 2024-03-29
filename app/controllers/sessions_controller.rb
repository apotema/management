class SessionsController < ApplicationController

  def new
  end

  def login
    user = User.find_by_login(params[:login])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user), notice: "You have logged in successfully"
    else
      flash.now.alert = "Email or password is invalid"
      render "new"
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to login_path, notice: "Logged out"
  end

end

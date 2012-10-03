class UsersController < ApplicationController

  load_and_authorize_resource only: :show

  def new
    respond_with @user = User.new
  end

  def create 
    respond_with @user = User.create(params[:user]), location: login_path
  end

  def show
    respond_with @user = User.find(params[:id])
  end

end
class UsersController < ApplicationController

  def new
    respond_with @user = User.new
  end

  def create 
    respond_with @user = User.create(params[:user])
  end

  def show
    respond_with @user = User.find(params[:id])
  end

end
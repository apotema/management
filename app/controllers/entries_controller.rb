class EntriesController < ApplicationController

  def new
    respond_with @entry = Entry.new
  end

  def create
    @entry = Entry.new(params[:entry])
    @entry.user = current_user
    @entry.save
    respond_with @entry
  end

  def show
    respond_with @entry = Entry.find(params[:id])
  end

  def edit
    respond_with @entry = Entry.find(params[:id])
  end

  def update
    respond_with @entry = Entry.update(params[:id], params[:entry])
  end

  def destroy 
    respond_with @entry = Entry.destroy(params[:id]), location: user_path(current_user)
  end

  def current_user
    User.create(name: "alexandre", login: "apotema", password: "123456")
  end


end
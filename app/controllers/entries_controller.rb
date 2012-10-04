class EntriesController < ApplicationController

  load_and_authorize_resource

  def new
    respond_with @entry = Entry.new
  end

  def create
    respond_with @entry = current_user.entries.create(params[:entry])
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

end
class EntriesController < ApplicationController

  def new
    respond_with @entry = Entry.new
  end

  def create
    respond_with @entry = Entry.create(params[:entry])
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

end
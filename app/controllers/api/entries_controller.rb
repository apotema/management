module Api
  class EntriesController < ApiController

    doorkeeper_for :all

    respond_to :json

    before_filter only: [:show, :update, :destroy] do
      @entry = Entry.find(params[:id])
      render(:json => {:error=>'unauthorised'}, status: :unauthorized) if current_user.id != @entry.user_id
    end

    def index
      respond_with @entries = current_user.entries
    end

    def show
      respond_with @entry
    end

    def create
      respond_with @entry = current_user.entries.create(params[:entry])
    end

    def update
      respond_with @entry = Entry.update(params[:id], params[:entry])
    end

    def destroy
      respond_with @entry = Entry.destroy(params[:id])
    end

  end
end
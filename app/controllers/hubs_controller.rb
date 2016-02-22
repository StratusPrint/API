class HubsController < ApplicationController
  before_action :set_hub, only: [:show, :update, :destroy]

  # GET /hubs
  def index
    @hubs = Hub.all

    render json: @hubs
  end

  # GET /hubs/1
  def show
    render json: @hub
  end

  # POST /hubs
  def create
    @hub = Hub.new(hub_params)

    if @hub.save
      render json: @hub, status: :created, location: @hub
    else
      render json: @hub.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /hubs/1
  def update
    if @hub.update(hub_params)
      render json: @hub
    else
      render json: @hub.errors, status: :unprocessable_entity
    end
  end

  # DELETE /hubs/1
  def destroy
    @hub.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hub
      @hub = Hub.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def hub_params
      params.fetch(:hub, {})
    end
end

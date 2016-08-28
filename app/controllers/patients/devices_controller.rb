class Patients::DevicesController < ApplicationController
  before_action :authenticate_header
  before_action :set_device, only: [:show, :update, :destroy]

  # GET /devices
  def index
    @devices = Device.all

    render json: @devices
  end

  # GET /devices/1
  def show
    render json: @device
  end

  # POST /devices
  def create
    @device = Device.new(device_params)
    if @device.save
      render json: { success: true,
                     info: 'Device saved',
                     data: {}}
    else
      errors = []
      @device.errors.full_messages.each { |e| errors << e}
      render json: { success: false,
                     info: "The following #{@device.errors.count} error(s) occured",
                     data: {errors: errors} }
    end
  end

  # PATCH/PUT /devices/1
  def update
    if @device.update(device_params)
      render json: @device
    else
      render json: @device.errors, status: :unprocessable_entity
    end
  end

  # DELETE /devices/1
  def destroy
    @device.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def device_params
      params.require(:device).permit(
          :patient_id,
          :platform,
          :token
      )
    end
end

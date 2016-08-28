class ClinicsController < ApplicationController
  before_action :set_clinic, only: [:show, :update, :destroy]

  # GET /clinics
  def index
    @clinics = Clinic.all

    render json: @clinics
  end

  # GET /clinics/1
  def show
    render json: @clinic
  end

  # POST /clinics
  def create
    @clinic = Clinic.new(clinic_params)

    if @clinic.save
      render json: @clinic, status: :created, location: @clinic
    else
      render json: @clinic.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /clinics/1
  def update
    if @clinic.update(clinic_params)
      render json: @clinic
    else
      render json: @clinic.errors, status: :unprocessable_entity
    end
  end

  # DELETE /clinics/1
  def destroy
    @clinic.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clinic
      @clinic = Clinic.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def clinic_params
      params.fetch(:clinic, {})
    end
end

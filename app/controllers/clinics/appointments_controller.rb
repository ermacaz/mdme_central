class Clinics::AppointmentsController < ApplicationController
  before_action :authenticate_header
  #return appointments for given date
  def index
    @clinic = Clinic.find(params[:clinic_id])
    @appointments = @clinic.appointments
    if params[:date]
      begin
        date = Date.parse(params[:date])
        @appointments = @appointments.where("start_time BETWEEN ? AND ?", date.beginning_of_day, date.end_of_day)
      rescue
        return render json: {
          success: false,
          message: 'Invalid date',
          data: {}
        }
      end
    end
    if params[:doctor_id].present?
      @appointments = @appointments.where(doctor_id: params[:doctor_id])
    end
    format = :as_json
    if params[:format]
      format = params[:format].to_sym
    end
    render json: {
        success: true,
        info: '',
        data: @appointments.map {|a| a.send(format)}
    }
  end
end
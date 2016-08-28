class Clinics::AppointmentsController < ApplicationController
  #return appointments for given date
  def index
    begin
      date = Date.parse(params[:date])
    rescue
      return render json: {
        success: false,
        message: 'Invalid date',
        data: {}
      }
    end
    @clinic = Clinic.find(params[:clinic_id])
    @appointments = @clinic.appointments.where("time >= ? AND time <= ?", date.beginning_of_day, date.end_of_day)
    if params[:doctor_id].present?
      @appointments = @appointments.where(doctor_id: params[:doctor_id])
    end
    render json: {
        success: true,
        info: '',
        data: @appointments
    }
  end
end
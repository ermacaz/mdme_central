class ApplicationController < ActionController::API

  def authenticate_header
    begin
      token = request.headers['Authorization'].split(' ').last
      payload, header = AuthToken.valid?(token)
      # instance_variabe_set("@" + payload['user_type'].downcase, payload['user_type'].constantize.find(payload['user_id']))
      @patient = Patient.find_by(id: payload['user_id'])
      # params[:patient_id] = @patient.id
    rescue
      render json: { error: 'Could not authenticate your request.  Please login'},
             status: :unauthorized
    end
  end
end


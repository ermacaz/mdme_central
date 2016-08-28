class LoginsController < ApplicationController
  def create
    patient = Patient.find_by(email: params[:email].downcase)
    if patient && patient.authenticate(params[:password])
      token = AuthToken.issue_token({user_id: patient.id, user_type: 'Patient', start_time: Time.zone.now.to_i})
      patient.update_attributes!(api_key: token)
      render json: {
        success: true,
        message: "Logged in as #{patient.full_name}",
        data: {
          user_id: patient.id,
          api_token: {
              token: token
          }
        }
      }
    else
      render json: {
        success: false,
        message: 'Invalid email/password combination',
        data: {}
        },
       status: :unauthorized
    end
  end

  def destroy
    authenticate_header
  end
end

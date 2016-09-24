class LoginsController < ApplicationController
  def create
    patient = Patient.find_by(email: params[:email].downcase)
    if patient && patient.authenticate(params[:password])
      token = AuthToken.issue_token({user_id: patient.id, user_type: 'Patient', start_time: Time.zone.now.to_i})
      clinics_json = [].as_json
      patient.update_attributes!(api_key: token)
      if params[:clinic_update_time].present?
        begin
          clinic_update_time = Time.zone.parse(params[:clinic_update_time])
          #have to compare string form, as objects they dont handle comparison well
          unless clinic_update_time.to_s == Clinic.all.order("updated_at DESC").first.updated_at.to_s
            clinics_json = patient.clinics.where("updated_at > ? ", clinic_update_time).as_json(except:[:created_at], :methods=>[:address_for_mobile])
          end
        rescue
          clinics_json = patient.clinics.as_json(except:[:created_at])
        end
      else
        clinics_json = patient.clinics.as_json(except:[:created_at])
      end
      render json: {
        success: true,
        message: "Logged in as #{patient.full_name}",
        data: {
          user_id: patient.id,
          api_token: {
              token: token
          },
          clinics: clinics_json
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

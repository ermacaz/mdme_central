class Appointment < ApplicationRecord
  has_many :appointment_clinic_procedures

  def duration
    self.appointment_clinic_procedures.sum(:duration)
  end
end

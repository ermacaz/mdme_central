class Appointment < ApplicationRecord
  has_and_belongs_to_many :clinic_procedures
  belongs_to :doctor
  belongs_to :patient
  belongs_to :clinic

  def duration
    self.appointment_clinic_procedures.sum(:duration)
  end
end

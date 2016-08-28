class AppointmentClinicProcedure < ApplicationRecord
  belongs_to :appointment
  belongs_to :clinic_procedure
  has_one :clinic, through: :clinic_procedure
end

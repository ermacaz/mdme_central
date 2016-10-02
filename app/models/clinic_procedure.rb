class ClinicProcedure < ApplicationRecord
  belongs_to :clinic
  belongs_to :procedure
  has_and_belongs_to_many :appointments

  delegate :name, to: :procedure

  def after_save
    self.clinic.touch
  end
end

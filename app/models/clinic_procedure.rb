class ClinicProcedure < ApplicationRecord
  belongs_to :clinic
  belongs_to :procedure
end

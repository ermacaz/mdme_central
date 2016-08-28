class ProcedureSymptom < ApplicationRecord
  belongs_to :procedure
  belongs_to :symptom
end

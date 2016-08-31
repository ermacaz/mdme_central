class Doctor < ApplicationRecord
  has_many :appointments
  has_and_belongs_to_many :clinics

  has_secure_password
end

class Procedure < ApplicationRecord
  has_and_belongs_to_many :symptoms
end

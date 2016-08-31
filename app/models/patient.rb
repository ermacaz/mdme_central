class Patient < ApplicationRecord
  has_many :appointments
  has_and_belongs_to_many :clinics
  has_many :devices

  enum marital_status: [ :single, :married, :divorced, :widowed, :other]
  enum sex: [ :male, :female ]

  has_secure_password

  validates :first_name,             presence: true, length: {maximum: 50}
  validates :last_name,              presence: true, length: {maximum: 50}
  validates :name_prefix,                            length: {maximum: 10}
  validates :name_suffix,                            length: {maximum: 10}
  validates :home_phone,                             length: {maximum: 20}
  validates :work_phone,                             length: {maximum: 20}
  validates :mobile_phone,                           length: {maximum: 20}
  validates :city,                   presence: true, length: {maximum: 50}
  validates :state,                                  length: {maximum: 2}
  validates :zipcode,                                length: {maximum: 11}
  validates :birthday,               presence: true, length: {maximum: 11}
  validate  :birthday_in_past
  validates :password, password_complexity: true, on: :create
  validates :email, presence: true, uniqueness: {case_sensitive: false},
            email_format: true, length: { maximum: 50 }
  before_save { self.email = email.downcase }

  def birthday_in_past
    if birthday.nil?
      errors.add(:birthday, "No birthday entered.")
    else
      errors.add(:birthday, "Birthday date must be set in the past.") if
          birthday > Time.zone.now
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

end

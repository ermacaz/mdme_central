class Clinic < ApplicationRecord

  has_many :clinic_procedures
  has_many :appointments
  has_and_belongs_to_many :patients
  has_and_belongs_to_many :doctors

  validates :name, presence: true, uniqueness: {scope: :address}
  validates :address, presence: true


  after_create :set_location_coordinates
  after_save   :set_location_coordinates, if: ->(clinic){ clinic.address_changed? or
                                                           clinic.city_changed?    or
                                                           clinic.state_changed?   or
                                                           clinic.zipcode_changed? or
                                                           clinic.country_changed?}
  # Called on clinic creation
  # Calls google geolocation api for latitude/longitude coordinates of
  # the clinic address.  Grabs NE and SW viewport coordinates for easier
  # google map rendering
  # will not change coordinates if invalid address supplied
  def set_location_coordinates
    address = "#{self.address.gsub('|', '+')}+" +
        ", #{self.city}+" +
        ", #{self.state unless self.state.nil?}+" +
        "#{self.country}"
    address.gsub!(' ', '+')
    GetLocationCoordinatesJob.perform_later(self, address)
  end

  # Helper for #set_location_coordinates
  # TODO possibly make the call in a thread
  def call_google_api_for_location(address)
    url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{
    address}&key=#{ENV['GOOGLE_API_KEY']}"
    response = HTTParty.get url
    response.body
  end
end

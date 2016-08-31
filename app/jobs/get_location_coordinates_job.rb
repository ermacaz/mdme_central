class GetLocationCoordinatesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    model = args[0]
    address = args[1]
    url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{
    address}&key=#{Rails.application.secrets.GOOGLE_API_KEY}"
    response = HTTParty.get url
    response = response.body
    json = JSON.parse(response)
    unless json['results'].empty?
      latitude = json['results'][0]['geometry']['location']['lat']
      longitude = json['results'][0]['geometry']['location']['lng']
      ne_latitude  = json['results'][0]['geometry']['viewport']['northeast']['lat']
      ne_longitude = json['results'][0]['geometry']['viewport']['northeast']['lng']
      sw_latitude  = json['results'][0]['geometry']['viewport']['southwest']['lat']
      sw_longitude = json['results'][0]['geometry']['viewport']['southwest']['lng']
      model_params = {}
      model_params['latitude']     = latitude     unless latitude.nil?
      model_params['longitude']    = longitude    unless longitude.nil?
      model_params['ne_latitude']  = ne_latitude  unless ne_latitude.nil?
      model_params['ne_longitude'] = ne_longitude unless ne_longitude.nil?
      model_params['sw_latitude']  = sw_latitude  unless sw_latitude.nil?
      model_params['sw_longitude'] = sw_longitude unless sw_longitude.nil?
      model.update_attributes!(model_params)
    end
  end
end

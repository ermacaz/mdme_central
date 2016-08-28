Rails.application.routes.draw do
  resources :devices
  resources :doctors
  resources :clinics
  resources :patients
  resources :appointments
  resources :logins, :only=>[:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

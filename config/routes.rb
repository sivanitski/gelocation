Rails.application.routes.draw do

  resources :geolocations, only: [:index, :destroy, :update] do
    collection do
      post "/geolocation", to: "geolocations#getGeolocation"
    end
  end
end

class GeolocationsController < ApplicationController
  before_action :authorize_request

  def index
    render json: { message: 'Geolocations Are Fetched succesffuly.', 'Geolocations': Geolocation.all, status: 'Ok' }
  end

  def destroy
    if params[:id]
      geoLocation = Geolocation.find_by_id(params[:id])
      if geoLocation.present?
        geoLocation.destroy
        render json: { message: 'Geolocation is deleted Successfully.', 'Geolocation': geoLocation, status: 'Ok' }
      else
        render json: {error: "No data found against id #{params[:id]}"}
      end
    end
  end

  def update
    if params[:id]
     geoLocation =  Geolocation.find_by_id(params[:id])
     if geoLocation.present?
       geoLocation.update(ip:params[:ip],
                         continent_code: params[:continent_code],
                         continent_name: params[:continent_name],
                         country_code: params[:country_code], 
                         country_name: params[:country_name], 
                         region_code: params[:region_code],
                         region_name: params[:region_name], 
                         city: params[:city],
                         zip: params[:zip], 
                         latitude: params[:latitude], 
                         longitude: params[:longitude])
        render json: {message: 'Geolocation is updated succesffuly', 'Geolocation': geoLocation, status: 'Ok'}
      else
        render json: {error: "No data found against id #{params[:id]}"}
      end
    else
      render json: {error: "id is missing"}
    end
  end

  def getGeolocation
    begin
    url = "http://api.ipstack.com/#{params['ip']}?access_key=#{ENV['ACCESS_KEY']}"
    @geoLocation = HTTParty.get(url)
    if @geoLocation.present?
     result =  create
      render json: { message: 'Geolocation is fetched succesffuly.', 'geolocation': result, status: 'Ok' }
    else
      render json: {error: "No data is fetched against IP:  #{params[:ip]}"}
    end
    rescue Exceptione => e
      render json: { message: 'Somethig wents wrong' , error: e}
    end
  end
  private

  def create
    return Geolocation.create(ip: @geoLocation['ip'],
                      continent_code: @geoLocation['continent_code'],
                      continent_name: @geoLocation['continent_name'],
                      country_code: @geoLocation['country_code'], 
                      country_name: @geoLocation['country_name'], 
                      region_code: @geoLocation['region_code'],
                      region_name: @geoLocation['region_name'], 
                      city: @geoLocation['city'],
                      zip: @geoLocation['zip'], 
                      latitude: @geoLocation['latitude'], 
                      longitude: @geoLocation['longitude'] )
  end

  def authorize_request
    unless (request.headers["access-token"] == 'bA4P6AnRySmzgGZmmMabGRsYC3bCb1Ru')
      render json: { error: "Unauthorized! Invalid authorization OR Missing access-token" }
    end
  end

end


require 'rails_helper'

RSpec.describe GeolocationsController, type: :controller do
  before :each do
    post :getGeolocation, params: {:ip => '134.201.250.155', format: :json}
    res = JSON.parse(response.body)
    @gelocation  = res['geolocation']
  end
 
  
  describe 'POST #geolocation' do
    it 'it should return the geolocation of given ip ' do
      post :getGeolocation, params: {:ip => '134.201.250.155', format: :json}
      res = JSON.parse(response.body)
      expect(res['message']).to eq 'Geolocation is fetched succesffuly.'
      expect(res['status']).to eq 'Ok'
      expect(res['geolocation']['ip']).to eq '134.201.250.155' if res['geolocation']['ip'] != nil
    end
  end
  
  describe 'GET #index' do
    it 'should get all the store geolocations ' do
      get :index
      res = JSON.parse(response.body)
      expect(res['message']).to eq 'Geolocations Are Fetched succesffuly.'
      expect(res['status']).to eq 'Ok'
      expect(res['Geolocations'].length).to be > 0
    end
  end

  describe 'DELETE #destroy' do
    it 'should delete geolocation' do
      delete :destroy, params: { id: @gelocation['id'], format: :json}
      res = JSON.parse(response.body)
      expect(res['message']).to eq 'Geolocation is deleted Successfully.'
      expect(res['status']).to eq 'Ok'
      expect(res['Geolocation']['id']).to eq @gelocation['id']
    end
    it 'should return error message' do
      delete :destroy, params: { id: 5, format: :json}
      res = JSON.parse(response.body)
      expect(res['error']).to eq "No data found against id #{5}"
    end
  end

  describe 'PUT #update' do
    it 'should update geolocation' do
      put :update, params: { id: @gelocation['id'], 
        ip: "127.0.0.2",
        continent_code: "AS1",
        continent_name: "Asia1",
        country_code: "PK1",
        country_name: "Pakistan1",
        region_code: "PB1",
        region_name: "Punjab1",
        city: "Lahore1",
        zip: 540001,
        latitude: "31.5633296966552731",
        longitude: "74.31333160400391", format: :json}
      res = JSON.parse(response.body)
      expect(res['message']).to eq 'Geolocation is updated succesffuly'
      expect(res['status']).to eq 'Ok'
      expect(res['Geolocation']['ip']).to eq '127.0.0.2'
    end
    it 'should return error message' do
      put :update, params: { id: 5, format: :json}
      res = JSON.parse(response.body)
      expect(res['error']).to eq "No data found against id #{5}"
    end
  end
end
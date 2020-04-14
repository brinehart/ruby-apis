module Api
  module V1
    class PlacesController < ApplicationController
      def index
        @places = Place.order('created_at DESC')
      def get_nearby_places
        url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{params[:latitude]},#{params[:longitude]}}&radius=500&key=#{Rails.application.secrets.google_places_key}";
        http_call = open(url).read
        response = JSON.parse(http_call, { symbolize_names: true } )
        @locations = response[:results]
        render json: { status: 'SUCCESS', message: 'Got Nearby Places', data: @locations}, status: :ok
      end
    end
  end
end
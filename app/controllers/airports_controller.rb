class AirportsController < ActionController::Base
  require 'rubygems'
  require 'geokit'
  include Geokit::Geocoders

  def index
    @airports = Airport.pluck(:name)
    render :index
  end

  def distance
    airport_a = Airport.where(name: params[:airport_a])[0]
    airport_b = Airport.where(name: params[:airport_b])[0]

    if airport_b && airport_a
      @distance = distance_from(airport_a, airport_b)
      render json: @distance
    else
      render json: "faulty"
    end
  end

  private

  def distance_from(a,b)
    airport_a = GoogleGeocoder.reverse_geocode([a.latitude,a.longitude])
    airport_b = GoogleGeocoder.reverse_geocode([b.latitude,b.longitude])
    return airport_a.distance_to(airport_b)
  end

  def airports_params
    params.require(:airport).permit(:airport_a, :airport_b)
  end
end

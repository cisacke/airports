class AirportsController < ActionController::Base
  require 'rubygems'
  require 'geokit'
  include Geokit::Geocoders
  Geokit::default_units = :nms  

  def index
    @airports = []
    Airport.pluck(:name).zip(Airport.pluck(:code)).each do |airport|
      @airports << airport.join(" (") + ")"
    end
    render :index
  end

  def distance
    airport_a = Airport.where(name: params[:airport_a].split(" (")[0])[0]
    airport_b = Airport.where(name: params[:airport_b].split(" (")[0])[0]

    if airport_b && airport_a
      @distance = distance_from(airport_a, airport_b)
      render json: @distance
    else
      render json: "faulty"
    end
  end

  def map
    airport_a = Airport.where(name: params[:airport_a].split(" (")[0])[0]
    airport_b = Airport.where(name: params[:airport_b].split(" (")[0])[0]

    @airports = [airport_a] + [airport_b]
    @hash = Gmaps4rails.build_markers(@airports) do |airport, marker|
      marker.lat airport.latitude
      marker.lng airport.longitude
    end
    render json: @hash
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

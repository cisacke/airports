class Airport < ActiveRecord::Base
  # require 'geokit'

  # def distance(a,b)
  #   airport_a = GoogleGeocoder.reverse_geocode([a.latitude,a.longitude])
  #   airport_b = GoogleGeocoder.reverse_geocode([b.latitude,b.longitude])
  #   return airport_a.distance_to(airport_b)
  # end

end

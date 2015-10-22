class Airport < ActiveRecord::Base
  validates :name, :code, :state, :longitude, :latitude, presence: true
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
def lat_long_conv(lat)
  if lat.split("")[-1] == "W" || lat.split("")[-1] == "S"
    lat = lat.chomp("W")
    split_lat = lat.split("-")
    # p split_lat
    split_lat.each_index do |idx|
      if idx == 0
        split_lat[idx] = split_lat[idx].to_i
      elsif idx == 1
        split_lat[idx] = (split_lat[idx].to_i / 60.0000)
      else
        split_lat[idx] = (split_lat[idx].to_i / 3600.00000)
      end

    end
    return (split_lat.inject(:+) * -1).to_s
    # negative
  elsif lat.split("")[-1] == "E" || lat.split("")[-1] == "N"
    lat = lat.chomp("E")
    split_lat = lat.split("-")
    # p split_lat
    split_lat.each_index do |idx|
      if idx == 0
        split_lat[idx] = split_lat[idx].to_i
      elsif idx == 1
        split_lat[idx] = (split_lat[idx].to_i / 60.0000)
      else
        split_lat[idx] = (split_lat[idx].to_i / 3600.00000)
      end
    end
    return split_lat.inject(:+).to_s
    # positive
end
  # split_lat.inject(:+)
end

lines = []
File.readlines('db/airports.txt').each do |line|
  lines << line
end
split_lines = lines[0].split("\r")
split_lines.each do |line|
  new_line = line.split("\t")
  state = new_line[0]
  name = new_line[1]
  code = new_line[2]
  latitude = lat_long_conv(new_line[3])
  p latitude
  longitude = lat_long_conv(new_line[4])
  p longitude

  # p new_line
  Airport.create(state: state, name: name, code: code, latitude: latitude, longitude: longitude)
end

# p new_line

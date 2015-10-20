# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
lines = []
File.readlines('db/airports.txt').each do |line|
  lines << line
end
# p lines.length
split_lines = lines[0].split("\r")
# p split_lines[1111].split("\t")
split_lines.each do |line|
  new_line = line.split("\t")
  state = new_line[0]
  name = new_line[1]
  code = new_line[2]
  latitude = new_line[3]
  longitude = new_line[4]

  p new_line
  Airport.create(state: state, name: name, code: code, latitude: latitude, longitude: longitude)
end

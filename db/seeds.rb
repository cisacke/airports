def read_file(file)
  lines = []
  File.readlines(file).each do |line|
    lines << line
  end
  lines[0].split("\r")
end

def deg_to_dec(val)
  if val.split("")[-1] == "W" || val.split("")[-1] == "S"
    return (decimal_calculator(val).inject(:+) * -1).to_s
  else
    return decimal_calculator(val).inject(:+).to_s
  end
end

def decimal_calculator(val)
  split_val = val.chop.split("-")

  split_val.each_index do |idx|
    if idx == 0
      split_val[idx] = split_val[idx].to_i
    elsif idx == 1
      split_val[idx] = (split_val[idx].to_i / 60.0)
    else
      split_val[idx] = (split_val[idx].to_f / 3600.0)
    end
  end
  split_val
end

airports = read_file("db/airports.txt")

airports.each do |airport|
  attributes = airport.split("\t")
  state = attributes[0]
  name = attributes[1]
  code = attributes[2]
  latitude = deg_to_dec(attributes[3])
  longitude = deg_to_dec(attributes[4])

  Airport.create(state: state,
                 name: name,
                 code: code,
                 latitude: latitude,
                 longitude: longitude)
end

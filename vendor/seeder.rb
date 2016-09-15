require 'json'
file = '/home/fatloris/downloads/sportgrounds.json'
json_ary = JSON.parse(open(file).read)
json_ary[0].each_pair {|key, value|
  puts "#{key} -------- #{value}"
}
# puts json_ary.each{|element|
#   puts element['Lat']
#   puts element['Lon']
#   puts element['Cells']['ObjectShortName']
#   puts element['Cells']['Address']
# }
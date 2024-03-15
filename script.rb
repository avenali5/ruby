# read file, parse and save in array
def read_discography(file_path)
  discography = {}

  File.open(file_path, "r") do |file|
    file.each_line do |line|
      year, *title_parts = line.chomp.split(" ")
      year = year.to_i
      title = title_parts.join(" ")
      discography[year] ||= []
      discography[year] << title
    end
  end

  discography
end

# sort by decades
def organize_by_decade(discography)
  organized = {}

  discography.each do |year, albums|
    decade = year - (year % 10)
    organized[decade] ||= {}
    organized[decade][year] ||= []
    organized[decade][year] += albums
  end

  organized
end

# calls
file_path = "discography.txt"
discography = read_discography(file_path)
organized = organize_by_decade(discography)

# print result in console
organized.keys.sort.each do |decade|
  puts "#{decade}s"
  organized[decade].keys.sort.each do |year|
    puts "  #{year}:"
    organized[decade][year].sort.each do |album|
      puts "  #{album}"
    end
  end
end
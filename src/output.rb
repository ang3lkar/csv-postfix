def output(headline, dataset)
  puts "\n#{headline}"
  dataset.each do |row|
    puts row.join(",")
  end
  puts "\n"
end

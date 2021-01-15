#!/usr/bin/ruby

require './src/output.rb'
require './src/csv_parser.rb'
require './src/postfix_evaluator.rb'

if ARGV.length != 1
    puts "\nScript expects exactly one parameter. The name of a file."
    puts "\tExample: ./main.rb source.csv"
    exit 1
end

filename = ARGV[0]

data = CsvParser.process(filename)
output("Input:", data)

evaluator = PostfixEvaluator.new(data)
results = evaluator.process
output("Output:", results)

exit 0

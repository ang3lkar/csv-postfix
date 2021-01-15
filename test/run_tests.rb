#!/usr/bin/ruby

require './src/csv_parser.rb'

def assert(expected, actual)
  if expected != actual
    puts "FAIL! expected '#{expected}' but got '#{actual}'"
    exit 1
  else
    puts "PASS!"
  end
end

data = CsvParser.process("./full-example.csv")

puts "CsvParser assertions:"
assert("1", data[0][0])
assert("B", data[0][1])
assert("2 3 + +", data[0][2])
assert("1 2 3 +", data[0][3])
assert("4 8 0 / +", data[0][4])
assert("", data[0][5])

assert("1 2 +", data[1][0])
assert("A1 A2 +", data[1][1])
assert("boom!", data[1][2])
assert("27", data[1][3])
assert("F1 0 *", data[1][4])
assert("A1 5 +", data[1][5])

assert("1 2 3 + +", data[2][0])
assert("A2 B2 +", data[2][1])
assert("12 1 -", data[2][2])
assert("7 8 *", data[2][3])
assert("9", data[2][4])
assert("F2", data[2][5])

assert("1  2  3  +  +", data[3][0])
assert("A2 A3 A4 + *", data[3][1])
assert("5", data[3][2])
assert("+ + +", data[3][3])
assert("1 2 +", data[3][4])
assert("F3", data[3][5])

assert("2 2  *", data[4][0])
assert("A2 C4 -", data[4][1])
assert("A2 C4 -", data[4][2])
assert("C5 3 +", data[4][3])
assert("2 3 +", data[4][4])
assert("F4", data[4][5])

assert("8 4 /", data[5][0])
assert("B7 2 +", data[5][1])
assert("B5    C4  -", data[5][2])
assert("2", data[5][3])
assert("F7 C4 +", data[5][4])
assert("F5", data[5][5])

assert("8 2 2 + /", data[6][0])
assert("A7 2 +", data[6][1])
assert("15 F1 /", data[6][2])
assert("E6", data[6][3])
assert("A7 A1 -", data[6][4])
assert("A1", data[6][5])


require './src/postfix_evaluator.rb'

evaluator = PostfixEvaluator.new(data)
results = evaluator.process

puts "\nPostfixEvaluator assertions:"
assert("1", results[0][0])
assert("#ERR", results[0][1])
assert("#ERR", results[0][2])
assert("#ERR", results[0][3])
assert("#ERR", results[0][4])
assert("0", results[0][5])

assert("3", results[1][0])
assert("4", results[1][1])
assert("#ERR", results[1][2])
assert("27", results[1][3])
assert("0", results[1][4])
assert("6", results[1][5])

assert("6", results[2][0])
assert("7", results[2][1])
assert("11", results[2][2])
assert("56", results[2][3])
assert("9", results[2][4])
assert("6", results[2][5])

assert("6", results[3][0])
assert("36", results[3][1])
assert("5", results[3][2])
assert("#ERR", results[3][3])
assert("3", results[3][4])
assert("6", results[3][5])

assert("4", results[4][0])
assert("-2", results[4][1])
assert("-2", results[4][2])
assert("1", results[4][3])
assert("5", results[4][4])
assert("6", results[4][5])

assert("2.0", results[5][0])
assert("6", results[5][1])
assert("-7", results[5][2])
assert("2", results[5][3])
assert("6", results[5][4])
assert("6", results[5][5])

assert("2.0", results[6][0])
assert("4", results[6][1])
assert("#ERR", results[6][2])
assert("6", results[6][3])
assert("1", results[6][4])
assert("1", results[6][5])


puts "\nAll tests passed successfully!"
exit 0

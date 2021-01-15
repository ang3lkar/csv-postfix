# Hello

This is a **Ruby** implementation for the Spreadsheet Programming Task.

## How to run
```sh
# Make it executable
chmod +x main.rb

./main.rb full-example.csv
```

## Run tests
```sh
# make it executable
chmod +x test/run_tests.rb

./test/run_tests.rb
```

# A few words

The story begins at `main.rb`. It accepts (only one) filename as an argument.

If a valid filename is given, the `CsvParser` reads the CSV file and loads its contents into a two-dimensional array, which serves perfectly as an data structure to hold our data.

The `PostfixEvaluator` is where the magic happens. It is provided with the array, and it performs the postfix operations in every cell. It's worth mentioning that the letter-number notation gets converted to array indexes to access referenced cells.

The `output.rb` contains just a function to print to STDOUT. There is also a small test that was written to help me with the implementation.

The `full-example.csv` contains numerous cases to verify the script can handle:
* Just numbers
* Empty cells
* All 4 operations
* 2 numbers, 1 operator
* 3 numbers, 2 operators
* 3 numbers, 2 different operators to verify correct operation order
* 2 cell references, 1 operator
* 3 cell references, 2 operators
* Traverse up to 4 cells to get value
* One or more spaces

It also contains invalid cells, to verify the the script can handle gracefully:
* Just letters
* Invalid postfix notations (incorrect number of operands/operators)
* Division by zero
* Random strings (eg. 'boom!')

## Assumptions

* The CSV is valid. Same number of columns in each row.
* Empty cells are considered as zero values.
* Cell cannot reference itself.

## Limitations

* Columns are limited to 26 (A-Z). No double letter notations.
* Circular dependencies between cells are not handled.

## Design Decisions

* Code can handle both uppercase and lowercase letters.

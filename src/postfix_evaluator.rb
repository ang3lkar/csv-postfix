class PostfixEvaluator
  NUMBER_PATTERN   = /^(\d)+$/
  OPERATOR_PATTERN = /^(\+|\-|\*|\/)$/
  CELL_PATTERN     = /^[A-Za-z]{1}[0-9]+$/

  def initialize(data)
    @data    = data
    @results = []
  end
  attr_reader :results

  def process
    @data.each_with_index do |row, i|
      @results[i] = []
      row.each_with_index do |cell, j|
        @results[i][j] = evaluate_postfix(cell, [])
      end
    end
    @results
  end

  private

  def evaluate_postfix(expression, visited_cells)
    stack = []

    # By convention, an empty cell is zero.
    if expression == ""
      return "0"
    end

    # split the string to array, eg. ['B1', 'B2', '+']
    tokens = expression.split

    tokens.each do |token|
      if NUMBER_PATTERN.match(token)
        # it's an operand, add to stack and continue
        stack.push(token)

      elsif OPERATOR_PATTERN.match(token)
        operand2 = stack.pop
        operand1 = stack.pop

        return "#ERR" if operand1.nil? || operand1.to_s.empty?
        return "#ERR" if operand2.nil? || operand2.to_s.empty?

        result = perform_operation(operand1.to_i, operand2.to_i, token)
        stack.push(result)

      elsif CELL_PATTERN.match(token)
        row_index, col_index = convert_letter_number_pair_to_array_indexes(token)

        # check if result has been evaluated already
        evaluated_cell   = @results[row_index].class == Array ? @results[row_index][col_index] : nil
        recursive_result = if evaluated_cell
                             evaluated_cell
                           else
                              if visited_cells.include?(token) # causes infinite loop
                                "#ERR"
                              else
                                visited_cells << token
                                evaluate_postfix(@data[row_index][col_index], visited_cells)
                              end
                           end

        stack.push(recursive_result)
      else
        return "#ERR"
      end
    end

    # if postfix expression is valid, stack should have one element by now
    if stack.length >= 2
      return "#ERR"
    end

    stack.pop.to_s
  rescue
    "#ERR"
  end

  def convert_letter_number_pair_to_array_indexes(token)
    matches = token.match /^(?<letter>[A-Za-z]{1})(?<number>[0-9]+)$/

    letter = matches[:letter].upcase # eg. 'B'
    number = matches[:number].to_i # eg. 2

    # B2 => 1,1
    row_index = number - 1
    col_index = letter.ord - 65

    return row_index, col_index
  end

  def perform_operation(operand1, operand2, operator)
    if operator == "+"
      operand1 + operand2
    elsif operator == "-"
      operand1 - operand2
    elsif operator == "*"
      operand1 * operand2
    elsif operator == "/"
      raise if operand2 == 0
      operand1.to_f / operand2
    end
  end

end

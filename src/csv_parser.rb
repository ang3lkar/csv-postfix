class CsvParser
  DELIMITER = ","

  # Arguments:
  # - filename: The filepath, eg. './some-file.csv'
  #
  # Returns:
  #   The CSV contents as a two-dimensional array
  def self.process(filename)
    data = []
    f = File.new(filename)
    f.readlines.each_with_index do |line, i|
      data[i] = []
      cells = line.split(DELIMITER)
      cells.each_with_index do |cell, j|
        data[i][j] = cell.strip
      end
    end
    data
  end

end

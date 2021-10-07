class Formatter
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def formatted_rows
    @formatted_rows ||= data.split("\n").map do |row|
      RowFormatter.new(row)
    end
  end

  def sorted_rows
    formatted_rows.sort
  end
end

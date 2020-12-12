module Day6
  module_function

  def p1(input = p1_input)
    input.map do |line|
      line.chars
    end.transpose.map do |line|
      counts = line.tally
      highest = counts.values.max
      counts.invert[highest]
    end.join
  end

  def p1_input(data = self.data)
    data
  end

  def p2(input = p2_input)
  end

  def p2_input
    p1_input
  end

  def e1(input = e1_input)
  end

  def e1_input
  end

  def data(filename = '06.input')
    @data ||= File.readlines(filename).map(&:strip)
  end

  def main
    puts "example 1: #{e1}"
    puts "part 1: #{p1}"
    puts "part 2: #{p2}"
    exit 0
  end
end

Day6.main if __FILE__ == $0

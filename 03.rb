class TriangleFilter
  attr_reader :input

  def initialize(input)
    @input = input
  end

  def triangles
    input.map do |line|
      line.strip.split(' ').map(&:to_i)
    end.each_slice(3).map do |group|
      group.transpose
    end.flatten(1).map(&:sort).select do |triangle|
      triangle[0] + triangle[1] > triangle[2]
    end
  end
end

if __FILE__ == $0
  puts TriangleFilter.new(File.readlines(ARGV[0])).triangles.size
end

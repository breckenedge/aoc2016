require 'irb'

triangles = File.readlines(ARGV[0]).map do |line|
  line.strip.split(' ').map(&:to_i)
end.each_slice(3).map do |group|
  group.transpose
end.flatten(1).select do |triangle|
  triangle.sort!
  triangle[0] + triangle[1] < triangle[2]
end

puts triangles.size

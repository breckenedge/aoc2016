require 'irb'

triangles = File.readlines(ARGV[0]).select do |line|
  sides = line.strip.split(' ').map(&:to_i).sort
  sides[0] + sides[1] > sides[2]
end

puts triangles.size

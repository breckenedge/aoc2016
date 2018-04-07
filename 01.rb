tests = {
  'R2, L3' => 5,
  'R2, R2, R2' => 2,
  'R5, L5, R5, R3' => 12
}

$dirs = [
  :north,
  :east,
  :south,
  :west
]

def grid_distance(path)
  x = 0; y = 0; dir = 0
  steps = path.split(',').map(&:strip)

  steps.each do |step|
    case step[0]
    when 'R'
      dir += 1
    when 'L'
      dir -= 1
    end

    distance = step[1..-1].to_i

    case $dirs[dir % 4]
    when :north
      y += distance
    when :east
      x -= distance
    when :south
      y -= distance
    when :west
      x += distance
    end
  end

  x.abs + y.abs
end

tests.each do |path, expected|
  puts grid_distance(path)
  puts grid_distance(path) == expected
end

puts grid_distance(DATA.read)

__END__
R4, R3, L3, L2, L1, R1, L1, R2, R3, L5, L5, R4, L4, R2, R4, L3, R3, L3, R3, R4, R2, L1, R2, L3, L2, L1, R3, R5, L1, L4, R2, L4, R3, R1, R2, L5, R2, L189, R5, L5, R52, R3, L1, R4, R5, R1, R4, L1, L3, R2, L2, L3, R4, R3, L2, L5, R4, R5, L2, R2, L1, L3, R3, L4, R4, R5, L1, L1, R3, L5, L2, R76, R2, R2, L1, L3, R189, L3, L4, L1, L3, R5, R4, L1, R1, L1, L1, R2, L4, R2, L5, L5, L5, R2, L4, L5, R4, R4, R5, L5, R3, L1, L3, L1, L1, L3, L4, R5, L3, R5, R3, R3, L5, L5, R3, R4, L3, R3, R1, R3, R2, R2, L1, R1, L3, L3, L3, L1, R2, L1, R4, R4, L1, L1, R3, R3, R4, R1, L5, L2, R2, R3, R2, L3, R4, L5, R1, R4, R5, R4, L4, R1, L3, R1, R3, L2, L3, R1, L2, R3, L3, L1, L3, R4, L4, L5, R3, R5, R4, R1, L2, R3, R5, L5, L4, L1, L1

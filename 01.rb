DIRS = %i[
  north
  east
  south
  west
]

class ManhattanPath
  def initialize(path)
    @path = path
    @x = 0
    @y = 0
    @direction = 0
    @visited = []
  end

  def crossover_distance
    enumerate_path do |step|
      turn = step[0]
      @direction += turn == 'R' ? 1 : -1
      distance = step[1..-1].to_i
      distance.times do
        case DIRS[@direction % 4]
        when :north
          @y += 1
        when :east
          @x -= 1
        when :south
          @y -= 1
        when :west
          @x += 1
        end

        if @visited.include?([@x, @y])
          return @x.abs + @y.abs
        else
          @visited << [@x, @y]
        end
      end
    end

    nil
  end

  def enumerate_path
    step = ''
    @path.each_char do |char|
      if char == ','
        yield step
      elsif char == ' '
        step = ''
      else
        step << char
      end
    end
    yield step
  end
end

if __FILE__ == $0
  puts ManhattanPath.new(StringIO.new('R8, R4, R4, R8')).crossover_distance == 4
  puts ManhattanPath.new(DATA).crossover_distance
end

__END__
R4, R3, L3, L2, L1, R1, L1, R2, R3, L5, L5, R4, L4, R2, R4, L3, R3, L3, R3, R4, R2, L1, R2, L3, L2, L1, R3, R5, L1, L4, R2, L4, R3, R1, R2, L5, R2, L189, R5, L5, R52, R3, L1, R4, R5, R1, R4, L1, L3, R2, L2, L3, R4, R3, L2, L5, R4, R5, L2, R2, L1, L3, R3, L4, R4, R5, L1, L1, R3, L5, L2, R76, R2, R2, L1, L3, R189, L3, L4, L1, L3, R5, R4, L1, R1, L1, L1, R2, L4, R2, L5, L5, L5, R2, L4, L5, R4, R4, R5, L5, R3, L1, L3, L1, L1, L3, L4, R5, L3, R5, R3, R3, L5, L5, R3, R4, L3, R3, R1, R3, R2, R2, L1, R1, L3, L3, L3, L1, R2, L1, R4, R4, L1, L1, R3, R3, R4, R1, L5, L2, R2, R3, R2, L3, R4, L5, R1, R4, R5, R4, L4, R1, L3, R1, R3, L2, L3, R1, L2, R3, L3, L1, L3, R4, L4, L5, R3, R5, R4, R1, L2, R3, R5, L5, L4, L1, L1

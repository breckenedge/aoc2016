class Instructions
  KEYPAD = [
    [ nil, nil,   1, nil, nil],
    [ nil,   2,   3,   4, nil],
    [   5,   6,   7,   8,   9],
    [ nil,  :A,  :B,  :C, nil],
    [ nil, nil,  :D, nil, nil]
  ]

  def initialize(starting_button: 5, instructions:)
    @starting_button = starting_button
    @y = KEYPAD.index { |row| row.include?(starting_button) }
    @x = KEYPAD[@y].index { |cell| cell == starting_button }
    @instructions = instructions
  end

  def calculate
    @instructions.each_line.map do |line|
      line.each_char do |char|
        x_was = @x
        y_was = @y
        case char.downcase
        when 'u'
          @y -= 1
        when 'l'
          @x -= 1
        when 'd'
          @y += 1
        when 'r'
          @x += 1
        end
        @x = 0 if @x < 0
        @y = 0 if @y < 0
        @x = KEYPAD.size - 1 if @x > KEYPAD.size - 1
        @y = KEYPAD.size - 1 if @y > KEYPAD.size - 1

        if button_at(@x, @y).nil?
          @x = x_was
          @y = y_was
        end
      end
      button_at(@x, @y).to_s
    end.join
  end

  def button_at(x, y)
    KEYPAD[y][x]
  end
end

if __FILE__ == $0
  puts Instructions.new(instructions: DATA.read).calculate
  puts Instructions.new(instructions: File.read(ARGV[0])).calculate
end

__END__
ULL
RRDDD
LURDL
UUUUD

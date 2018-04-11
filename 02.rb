class Instructions
  KEYPAD = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
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
        @x = 2 if @x > KEYPAD.size - 1
        @y = 0 if @y < 0
        @y = 2 if @y > KEYPAD.size - 1
      end
      button_at(@x, @y).to_s
    end.join
  end

  def button_at(x, y)
    KEYPAD[y][x]
  end
end

if __FILE__ == $0
  puts 1985 == Instructions.new(instructions: DATA.read).calculate.to_i
  puts Instructions.new(instructions: File.read(ARGV[0])).calculate.to_i
end

__END__
ULL
RRDDD
LURDL
UUUUD

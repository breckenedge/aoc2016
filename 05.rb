require 'pry'
require 'digest'

class PasswordCracker
  attr_reader :input

  def initialize(input)
    @input = input
  end

  def password
    index = 0
    interestings = []

    loop do
      digest = Digest::MD5.hexdigest("#{input}#{index}")

      if digest[0,5] == '00000'
        interestings << digest[5]
      end

      index += 1

      break if interestings.size == 8
    end
    interestings.join
  end
end

if __FILE__ == $0
  puts PasswordCracker.new(ARGV[0]).password
end

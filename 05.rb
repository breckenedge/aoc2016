require 'pry'
require 'digest'

class PasswordCracker
  attr_reader :cinematic, :input

  def initialize(input, cinematic: false)
    @cinematic = cinematic
    @input = input
  end

  def password
    index = 0
    interestings = Array.new(8)

    loop do
      digest = Digest::MD5.hexdigest("#{input}#{index}")

      if digest =~ /^00000[0-7]/
        interestings[digest[5].to_i] ||= digest[6]
      end

      index += 1

      print "\r#{interestings.map.with_index { |v, i| v.nil? ? digest[i] : v }.join}" if cinematic

      if interestings.none?(&:nil?)
        print "\n" if cinematic
        break
      end
    end
    interestings.join
  end
end

if __FILE__ == $0
  password = PasswordCracker.new(ARGV[0], cinematic: !ENV['CINEMATIC'].nil?).password
  puts password
end

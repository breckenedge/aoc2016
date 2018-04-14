require 'pry'

class RealRoomsSelector
  PATTERN = /(?<encrypted_name>([a-z-]+))-(?<checksum>[0-9]+)\[(?<most_common_letters>[a-z]+)\]/

  attr_reader :input

  def initialize(input)
    @input = input
  end

  def real_rooms
    input.map { |line|
      PATTERN.match(line)
    }.compact.select { |matches|
      most_common_chrs = []

      chr_freqs = matches[:encrypted_name].gsub('-', '').each_char.with_object({}) do |chr, hash|
        hash[chr] ? hash[chr] += 1 : hash[chr] = 1
      end

      next if chr_freqs.keys.size < 5

      freq_chrs = chr_freqs.each_with_object({}) do |(chr, freq), hash|
        hash[freq] ? hash[freq] << chr : hash[freq] = [chr]
      end

      freq_chrs = freq_chrs.sort_by { |k, _| k }.reverse.to_h

      freq_chrs.each_value(&:sort!)

      most_common_chrs = freq_chrs.values.flatten

      matches[:most_common_letters] == most_common_chrs[0, 5].join
    }.map { |matches|
      RealRoom.new(matches[:encrypted_name], matches[:checksum].to_i, matches[:most_common_letters])
    }
  end

  private

  RealRoom = Struct.new(:encrypted_name, :checksum, :most_common_letters)
end

if __FILE__ == $0
  input = (ARGV.empty? ? DATA : ARGF).readlines.map(&:chomp)
  real_rooms = RealRoomsSelector.new(input).real_rooms
  puts real_rooms.sum(&:checksum)
end

__END__
aaaaa-bbb-z-y-x-123[abxyz]
a-b-c-d-e-f-g-h-987[abcde]
not-a-real-room-404[oarel]
totally-real-room-200[decoy]

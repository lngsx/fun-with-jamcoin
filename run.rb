require_relative 'jamcoin.rb'

File.open('./input', 'r') do |f|
  aa = []

  f.each_line do |line|
    aa.push line
  end

  thecase = aa[0].to_i.to_s
  given_number = aa[1].split(' ')

  # N is sample length
  N = given_number[0].to_i
  # J is sample number
  J = given_number[1].to_i

  jamcoins = []

  puts 'Calculating...'

  output_text = 'Case #' + thecase + ':' + "\n"

  # Don't stop until the jamcoin produced to meet the goal (J)
  J.times do
    jamicon = Jamcoin.new(length: N)

    # prevent the duplication
    while jamcoins.map { |x| x.digits.join }.include? jamicon.digits.join
      jamicon = Jamcoin.new(length: N)
    end
    jamcoins.push jamicon

    preview_text = jamicon.digits.join + ' ' + jamicon.divisors.join(' ') + "\n"

    puts preview_text

    output_text += preview_text
  end

  puts 'Done!'

  File.write('./output', output_text)
end

class Jamcoin
  require 'prime'
  attr_reader :digits, :divisors

  def initialize(params = {})
    @length = params.fetch(:length)
    loop do
      generate
      break if jamcoined
    end
  end

  def generate
    # create an array with the length minus 2
    # since we don't need the first and the last ramdom.
    sample_digits = Array.new(@length - 2)

    # populate array by random pick of 0 and 1
    sample_digits.map! { [0, 1].sample }

    # make first and last digit '1'
    sample_digits.unshift 1
    sample_digits.push 1

    @digits = sample_digits
  end

  def divisors_of(number)
    sample = nil

    dv = number.prime_division.map(&:first)

    dv.delete(1)
    dv.delete(number)

    sample = dv.sample if dv.length > 1

    sample
  end

  def interprete_by(base_number)
    @digits.join.to_i(base_number)
  end

  def jamcoined
    # create an array populated by serial 2-10
    base_numbers = Array(2..10)

    # interpret sample and check if it is prime number. 
    # resulted in the array of nontrival divisors.
    @divisors = base_numbers.map { |base_number| divisors_of(interprete_by(base_number)) }

    # check if the array contain nil which means it is contain prime number.
    # return true if this digits is jamcoin
    @divisors.include?(nil) ? false : true
  end
end

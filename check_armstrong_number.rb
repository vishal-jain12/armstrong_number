class CheckArmstrongNumber
  require 'benchmark'
  require 'benchmark/memory'

  def validate_armstrong_number
    input_length = @number.split('').length
    number = @number.to_i
    if number == 0
      puts "Input should be integer and greater than zero"
      return false
    end
    if input_length > 5
      puts "Input number should be upto 5 digits only"
      return false
    end
    @is_valid = validate_number(number, input_length)
    @result = @is_valid ? "#{@number}, Its an Armstrong Number" : "#{@number}, Its Not an Armstrong Number"
    unless @is_valid
      @closest_highest_number = get_closest_greater_number
      @closest_smaller_number = get_closest_smaller_number
    end
  end

  def get_closest_greater_number
    (@temporary_number + 1).upto(999999) do |num|
      num_length = num_digits(num)
      is_valid = validate_number(num, num_length)
      if is_valid
        @num = num
        break
      end
    end
    @num
  end

  def get_closest_smaller_number
    (@temporary_number - 1).downto(1) do |num|
      num_length = num_digits(num)
      is_valid = validate_number(num, num_length)
      if is_valid
        @num = num
        break
      end
    end
    @num
  end

  def num_digits(num)
    Math.log10(num).to_i + 1
  end

  def validate_number(number, input_length)
    sum = 0
    @temporary_number = number
    while number != 0
      rem = number%10
      number = number/10
      sum += rem ** input_length
    end
    return sum == @temporary_number
  end

  def check_armstrong_input
    puts "Enter the Number, Number should be greater than zero and upto 5 digits only"
    @number = gets.chomp
    time = Benchmark.realtime do
      validate_armstrong_number
    end
    Benchmark.memory do |x|
      x.report("Armstrong Number Memory Usage") {validate_armstrong_number}
    end
    puts @result
    unless @is_valid
      puts "Closest Highest Number is #{@closest_highest_number}"
      puts "Closest Smallest Number is #{@closest_smaller_number}"
    end
    puts "Execution Time: #{time}"
  end
end

check_number = CheckArmstrongNumber.new
check_number.check_armstrong_input
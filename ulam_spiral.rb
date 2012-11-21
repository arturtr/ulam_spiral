class UlamSpiral
  def initialize length
    @length = length.to_i
    @root = Math.sqrt(@length).to_i
    @spiral = [[1]]
  end

  def square?
    @root ** 2 == @length
  end

  def build
    unless square?
      puts "Output: #{@length} is not a perfect square"
      exit
    end

    (2..@root).each do |step|
      if step.even?
        add_right_top step
      else
        add_left_bottom step
      end
    end
    @spiral
  end

  protected

  def add_right_top step
    addition = addition(step)
    first_part = addition.shift(addition.length / 2)
    @spiral = @spiral.transpose << first_part.reverse
    @spiral = @spiral.transpose.unshift addition.reverse
  end

  def add_left_bottom step
    addition = addition(step)
    first_part = addition.shift(addition.length / 2)
    @spiral = @spiral.transpose.unshift first_part
    @spiral = @spiral.transpose << addition
  end

  def addition(step)
    (((step - 1) ** 2 + 1)..(step ** 2)).to_a
  end
end

length = ARGV.first.to_i

if length > 0
  puts "Input:  #{length}"
  spiral = UlamSpiral.new length
  matrix = spiral.build
  puts "Output: #{matrix.shift.map {|el| el.to_s.center(length.to_s.length + 1)}.join}"
  matrix.each do |line|
    puts "        #{line.map {|el| el.to_s.center(length.to_s.length + 1)}.join}"
  end
else
  puts "Put square length as parameter"
end


require 'byebug'

def solve_equation(equation)
  re = /[+-]?\d*x?/
  x_co = 0
  val = 0
  left, right = equation.split("=")
  left = left.scan(re)
  right = right.scan(re)
  left.each do |set|
    if set.include?("x")
      m = set.match(/([+-]?\d+)x/)
      if m
        x_co += m[1].to_i
      else
        x_co += set.include?("-") ? -1 : 1
      end
    else
      val -= set.to_i
    end
  end
  # puts x_co
  # puts val
  right.each do |set|
    if set.include?("x")
      m = set.match(/([+-]?\d+)x/)
      if m
        x_co -= m[1].to_i
      else
        x_co += set.include?("-") ? 1 : -1
      end
    else
      val += set.to_i
    end
  end
  # puts left
  # puts right
  # puts x_co
  # puts val
  if x_co == 0
    return val == 0 ? "Infinite solutions" : "No solution"
  end
  answ =(val/x_co).to_i
  "x=#{answ}"
end

# testeq = "-x=-1"
# re = /[+-]?\d*x?/
# p solve_equation(testeq)
# p solve_equation("x+5-3+x=6+x-2")
# p solve_equation("x=x")
# p solve_equation("2x=x")
# p solve_equation("2x+3x-6x=x+2")
# p solve_equation("x=x+2")

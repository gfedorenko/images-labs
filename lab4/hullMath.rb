require 'matrix'

module HullMath
  
  def HullMath.standardFormOfLineFunction(a_point, b_point)
    a = b_point.y - a_point.y
    b = a_point.x - b_point.x
    c = a_point.x * b_point.y - a_point.y * b_point.x
    return Proc.new {
        |point|
      if (a*point.x + b*point.y > c)
        1
        # (x, y) is on the line.
      elsif (a*point.x + b*point.y == c)
        0
        # (x, y) is "above" the line.
      else
        -1
      end
    }
  end


  def HullMath.determinantFunction(a_point, b_point)
    return Proc.new {
        |point|
      Matrix[[a_point.x, a_point.y, 1], [b_point.x, b_point.y, 1], [point.x, point.y, 1]].determinant
    }
  end

end
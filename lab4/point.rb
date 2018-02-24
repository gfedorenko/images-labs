# This class represents a point on a 2-dimensional plane.

class Point

  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def setCoords(x, y)
    @x = x
    @y = y
  end

end
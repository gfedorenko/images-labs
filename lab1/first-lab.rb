require "matrix"

class Point < Vector
  # attr_accessor :p

  # def initialize()
  #   super
  # end

  # def reset(x, y)
  #   @x = x
  #   @y = y
  # end
end

class Polygon

  def initialize(p)
    @edges = p.length
    @vertices = sort(p)
  end

  def convex
    vectors = []
    for i in 1..@edges
      vectors << @vertices[i % @edges] - @vertices[i-1]
    end
    cross_prod = each_cross_prod(vectors)
    return same_direction(cross_prod) ? true : false
  end

  def isInside(target)
    if convex
      target_arr = target_arr(target)
      cross_prod = each_cross_prod(target_arr)
      return same_direction(cross_prod) ? 1 : 0
    end

    return -1
  end

  protected
  def sort(p)

    x = y = 0
    for v in p
      x += v[0]
      y += v[1]
    end
    avg_dot = [x/@edges, y/@edges]

    arctan = []
    for v in p
      arctan << Math.atan2(v[0] - avg_dot[0], v[1] - avg_dot[1])
    end
    ind = arctan.map{|e| arctan.sort.index(e)}
    p = p.sort_by{|x| ind[p.index(x)]}
    return p
  end

  def target_arr(target)
    target_arr = []
    for v in @vertices
      target_arr << v - target
    end
    return target_arr
  end

  def each_cross_prod(vectors)

    cross_prod = []
    len = vectors.length

    for i in 1..len
      cross_prod << vectors[i-1].cross_prod(vectors[i % @edges])
    end

    return cross_prod
  end

  def same_direction(cross_prod)
    len = cross_prod.length
    for i in 1..len
      if cross_prod[i-1][2] * cross_prod[i % len][2] < 0
        return false
      end
    end
    return true
  end

  def left_or_right point
    (@end.y - @start.y) * (point.x - @start.x) - (point.y - @start.y) * (@end.x - @start.x)
  end


  def on_the_left? p
    left_or_right(p) > 0
  end

  def on_the_right? p
    left_or_right(p) < 0
  end

  def point_is_on? p
    left_or_right(p) == 0
  end

end

points = []
points << Point[0,0]
points << Point[10,0]
points << Point[10,10]
points << Point[0,10]

a = Polygon.new(points)

target = Point[5,6]

status = a.isInside(target)

case status
  when 1
    puts "Inside"
  when 0
    puts "Outside"
  when -1
    puts "You need to give a convex polygon"
end
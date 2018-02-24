require_relative './hull'
require_relative './point'

      qh = Hull.new(Plane.new(100, 100, 50))
      qh.findConvexHull

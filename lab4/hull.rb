require_relative './hullMath'
require_relative './plane'
require 'csv'


class Hull

  attr_reader :plane, :hullPoints

  def initialize(plane)
    @plane = plane
    @plane.sortPoints
    @hullPoints = Array.new
  end

  def findConvexHull
    min_point = @plane.points[0]
    max_point = @plane.points[-1]
    @hullPoints.push(min_point)
    @hullPoints.push(max_point)
    upper_hull, lower_hull = splitPlane(@plane, min_point, max_point)

    findHull(upper_hull, min_point, max_point)
    findHull(lower_hull, max_point, min_point)
    return @hullPoints
  end

  def findHull(plane, min_point, max_point)
    if plane.points.empty?
      return
    end

    furth_point = findFurthest(plane, min_point, max_point)
    if furth_point.nil?
      return
    end
    @hullPoints = insertFurthestAfter(min_point, furth_point, @hullPoints)

    findHull(plane, min_point, furth_point)
    findHull(plane, furth_point, max_point)
  end

  def writeHullTo(file)
    puts ["x", "y"]
    @hullPoints.each do |point|
      puts [point.x, point.y]
    end
    puts  [@hullPoints[0].x, @hullPoints[0].y]
  end

  def writePlaneTo(file)
    @plane.writePointsToCsv(file)
  end

  def findFurthest(plane, min_point, max_point)
    max = {:point => nil, :val => 0}
    function = HullMath.determinantFunction(min_point, max_point)
    plane.points.each do |point|
      val = function.call(point)
      if val > max[:val]
        max[:val] = val
        max[:point] = point
      end
    end
    return max[:point]
  end

  def insertFurthestAfter(val, furthest, arr)
    arr.each_index do |i|
      if arr[i].eql? val
        arr.insert(i + 1, furthest)
        return arr
      end
    end
  end

  def splitPlane(plane, min_point, max_point)
    upper_hull = Plane.new(0,0,0)
    lower_hull = Plane.new(0,0,0)
    dFunct = HullMath.determinantFunction(min_point, max_point)
    plane.points.each do |point|
      val = dFunct.call(point)
      if val > 0
        upper_hull.addPoint(point)
      end
      if val < 0
        lower_hull.addPoint(point)
      end
    end
    return upper_hull, lower_hull
  end

end
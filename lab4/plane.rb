require 'csv'
require_relative './Point'


class Plane

  attr_reader :points, :height, :width

  def initialize(height, width, numPoints)
    @height = height
    @width = width
    @points = generatePoints(numPoints)
  end

  def addPoint(point)
    @points.push(point)
  end

  def allPointsAdjacentOrOnLine?(standardFormLineFunct)
    side_seen = nil
    @points.each do |point|
      side = standardFormLineFunct.call(point)
      if side_seen.nil? or side == 0
        side_seen = side unless side == 0
      else
        if side_seen != side then return false end
      end
    end
    return true
  end

  def writePoints(fileName)
    puts ["x", "y"]
    @points.each do |point|
      puts [point.x, point.y]
    end
  end

  def sortPoints
    @points.sort! { |a, b| a.x <=> b.x }
  end

  private

  def generatePoints(numPoints)
    collection = []
    numPoints.times do
      collection.push(Point.new(rand(0..@height), rand(0..@width)))
    end
    return collection
  end

end
class Rectangle
  attr_reader :top_left, :width, :height

  def initialize(point, width, height)
    @top_left = point
    @width = width
    @height = height
  end

  def left_edge
    @top_left.x
  end
end

class Point
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end
end

point = Point.new(5, 7)
rect = Rectangle.new(point, 20, 30)

puts point
puts rect

# Want to avoid rectangle having knowledge of the implementation of point when
# finding the x-coordinate of the rectangle's left edge.
puts rect.top_left.x

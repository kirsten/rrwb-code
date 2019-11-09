require_relative 'svg'

class Sparkline
  def initialize(y_values)
    @y_values = y_values
  end

  def to_svg
    "<svg xmlns=\"http://www.w3.org/2000/svg\"
         xmlns:xlink=\"http://www.w3.org/1999/xlink\" >
      #{x_axis}
      #{sparkline}
      #{spark}
    </svg>"
  end

  private

  attr_reader :y_values

  SQUARE_SIDE = 4
  SQUARE_COLOR = "red"

  def x_axis
    "<!-- x-axis -->
    #{SVG.line(0, 200, y_values.length, 200, "#999", 1)}"
  end

  def sparkline
    points = []
    y_values.each_index { |i| points << "#{i},#{200 - y_values[i]}" }
    "<!-- sparkline -->
    #{SVG.polyline("none", "#333", 1, points)}"
  end

  def spark
    final_value = y_values[-1]
    center_x = y_values.length - 1
    center_y = 200 - final_value
    "<!-- spark -->
    #{SVG.rect(center_x - (SQUARE_SIDE / 2), center_y - (SQUARE_SIDE / 2), SQUARE_SIDE, SQUARE_SIDE, SQUARE_COLOR, "none", 0)}\"
    <!-- final value -->
    #{SVG.text(center_x, center_y, "Verdana", 9, SQUARE_COLOR, final_value)}"
  end
end


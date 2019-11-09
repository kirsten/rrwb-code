require_relative 'svg'

class Sparkline
  def initialize(y_values)
    @height_above_x_axis = y_values.max
    @final_value = y_values[-1]
    @y_values = reflect_top_and_bottom(y_values)
  end

  def to_svg
    "<svg xmlns=\"http://www.w3.org/2000/svg\"
         xmlns:xlink=\"http://www.w3.org/1999/xlink\" >
      <g transform=\"translate(0, #{@height_above_x_axis})\">
        #{x_axis}
        #{sparkline}
        #{spark}
      </g>
    </svg>"
  end

  def reflect_top_and_bottom(y_values)
    y_values.map { |y| -y }
  end

  private

  attr_reader :y_values

  SQUARE_SIDE = 4
  SQUARE_COLOR = "red"

  def x_axis
    "<!-- x-axis -->
    #{SVG.line(0, 0, y_values.length, 0, "#999", 1)}"
  end

  def sparkline
    points = []
    y_values.each_index { |i| points << "#{i},#{y_values[i]}" }
    "<!-- sparkline -->
    #{SVG.polyline("none", "#333", 1, points)}"
  end

  def spark
    center_x = y_values.length - 1
    center_y = y_values[-1]
    "<!-- spark -->
    #{SVG.rect(center_x - (SQUARE_SIDE / 2), center_y - (SQUARE_SIDE / 2), SQUARE_SIDE, SQUARE_SIDE, SQUARE_COLOR, "none", 0)}\"
    <!-- final value -->
    #{SVG.text(center_x + 6, center_y + 4, "Verdana", 9, SQUARE_COLOR, @final_value)}"
  end
end


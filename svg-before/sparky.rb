require_relative 'svg'

class Sparkline
  attr_reader :y_values

  def initialize(y_values)
    @y_values = y_values
  end

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
end

def toss
  2 * (rand(2)*2 - 1)
end

def values(n)
  a = [0]
  n.times { a << (toss + a[-1]) }
  a
end

SQUARE_SIDE = 4
SQUARE_COLOR = "red"

def spark(y_values)
  final_value = y_values[-1]
  center_x = y_values.length - 1
  center_y = 200 - final_value
  "<!-- spark -->
  #{SVG.rect(center_x - (SQUARE_SIDE / 2), center_y - (SQUARE_SIDE / 2), SQUARE_SIDE, SQUARE_SIDE, SQUARE_COLOR, "none", 0)}\"
  <!-- final value -->
  #{SVG.text(center_x, center_y, "Verdana", 9, SQUARE_COLOR, final_value)}"
end

sp = Sparkline.new(values(1000))

data = "<svg xmlns=\"http://www.w3.org/2000/svg\"
     xmlns:xlink=\"http://www.w3.org/1999/xlink\" >
  #{sp.x_axis}
  #{sp.sparkline}
  #{spark(sp.y_values)}
</svg>"

puts "Content-Type: image/svg+xml
Content-Length: #{data.length}

#{data}"

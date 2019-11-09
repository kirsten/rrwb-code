require_relative 'svg'

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

def x_axis(y_values)
  "<!-- x-axis -->
  #{SVG.line(0, 200, y_values.length, 200, "#999", 1)}"
end

def sparkline(points)
  "<!-- sparkline -->
  #{SVG.polyline("none", "#333", 1, points)}"
end

tosses = values(1000)
points = []
tosses.each_index { |i| points << "#{i},#{200-tosses[i]}" }

data = "<svg xmlns=\"http://www.w3.org/2000/svg\"
     xmlns:xlink=\"http://www.w3.org/1999/xlink\" >
  #{x_axis(tosses)}
  #{sparkline(points)}
  #{spark(tosses)}
</svg>"

puts "Content-Type: image/svg+xml
Content-Length: #{data.length}

#{data}"

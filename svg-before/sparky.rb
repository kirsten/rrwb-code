require_relative 'svg'

NUMBER_OF_TOSSES = 1000

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

def spark(center_x, center_y, value)
  "#{SVG.rect(center_x - (SQUARE_SIDE / 2), center_y - (SQUARE_SIDE / 2), SQUARE_SIDE, SQUARE_SIDE, SQUARE_COLOR, "none", 0)}\"
   #{SVG.text(center_x, center_y, "Verdana", 9, SQUARE_COLOR, value)}"
end

tosses = values(NUMBER_OF_TOSSES)
points = []
tosses.each_index { |i| points << "#{i},#{200-tosses[i]}" }

data = "<svg xmlns=\"http://www.w3.org/2000/svg\"
     xmlns:xlink=\"http://www.w3.org/1999/xlink\" >
  <!-- x-axis -->
  #{SVG.line(0, 200, NUMBER_OF_TOSSES, 200, "#999", 1)}
  #{SVG.polyline("none", "#333", 1, points)}
  #{spark(NUMBER_OF_TOSSES-1, 200-tosses[-1], tosses[-1])}
</svg>"

puts "Content-Type: image/svg+xml
Content-Length: #{data.length}

#{data}"

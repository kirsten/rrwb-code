NUMBER_OF_TOSSES = 1000

def toss
  2 * (rand(2)*2 - 1)
end

def values(n)
  a = [0]
  n.times { a << (toss + a[-1]) }
  a
end

def rect(center_x, center_y, width, height, fill, stroke, stroke_width)
  "<rect x=\"#{center_x - 2}\" y=\"#{center_y - 2}\"
    width=\"#{width}\" height=\"#{height}\"
    fill=\"#{fill}\" stroke=\"#{stroke}\" stroke-width=\"#{stroke_width}\" />"
end

def text(center_x, center_y, font_family, font_size, fill, message)
  "<text x=\"#{center_x + 6}\" y=\"#{center_y + 4}\"
    font-family=\"#{font_family}\" font-size=\"#{font_size}\"
    fill=\"#{fill}\" >#{message}</text>"
end

def line(x1, y1, x2, y2, stroke, stroke_width)
  "<line x1=\"#{x1}\" y1=\"#{y1}\" x2=\"#{x2}\" y2=\"#{y2}\" stroke=\"#{stroke}\" stroke-width=\"#{stroke_width}\" />"
end

def polyline(fill, stroke, stroke_width, points)
  "<polyline fill=\"#{fill}\" stroke=\"#{stroke}\" stroke-width=\"#{stroke_width}\" points = \"#{points.join(' ')}\" />"
end

def spark(center_x, center_y, value)
  "#{rect(center_x, center_y, 4, 4, "red", "none", 0)}\"
   #{text(center_x, center_y, "Verdana", 9, "red", value)}"
end

tosses = values(NUMBER_OF_TOSSES)
points = []
tosses.each_index { |i| points << "#{i},#{200-tosses[i]}" }

data = "<svg xmlns=\"http://www.w3.org/2000/svg\"
     xmlns:xlink=\"http://www.w3.org/1999/xlink\" >
  <!-- x-axis -->
  #{line(0, 200, NUMBER_OF_TOSSES, 200, "#999", 1)}
  #{polyline("none", "#333", 1, points)}
  #{spark(NUMBER_OF_TOSSES-1, 200-tosses[-1], tosses[-1])}
</svg>"

puts "Content-Type: image/svg+xml
Content-Length: #{data.length}

#{data}"

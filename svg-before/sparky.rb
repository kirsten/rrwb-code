NUMBER_OF_TOSSES = 1000

def toss
  2 * (rand(2)*2 - 1)
end

def values(n)
  a = [0]
  n.times { a << (toss + a[-1]) }
  a
end

def rect(center_x, center_y)
  "<rect x=\"#{center_x - 2}\" y=\"#{center_y - 2}\"
    width=\"4\" height=\"4\"
    fill=\"red\" stroke=\"none\" stroke-width=\"0\" />"
end

def text(center_x, center_y, value)
  "<text x=\"#{center_x + 6}\" y=\"#{center_y + 4}\"
    font-family=\"Verdana\" font-size=\"9\"
    fill=\"red\" >#{value}</text>"
end

def spark(center_x, center_y, value)
  "#{rect(center_x, center_y)}\"
   #{text(center_x, center_y, value)}"
end

$tosses = values(NUMBER_OF_TOSSES)
points = []
$tosses.each_index { |i| points << "#{i},#{200-$tosses[i]}" }

data = "<svg xmlns=\"http://www.w3.org/2000/svg\"
     xmlns:xlink=\"http://www.w3.org/1999/xlink\" >
  <!-- x-axis -->
  <line x1=\"0\" y1=\"200\" x2=\"#{NUMBER_OF_TOSSES}\" y2=\"200\"
            stroke=\"#999\" stroke-width=\"1\" />
  <polyline fill=\"none\" stroke=\"#333\" stroke-width=\"1\"
    points = \"#{points.join(' ')}\" />
  #{spark(NUMBER_OF_TOSSES-1, 200-$tosses[-1], $tosses[-1])}
</svg>"

puts "Content-Type: image/svg+xml
Content-Length: #{data.length}

#{data}"

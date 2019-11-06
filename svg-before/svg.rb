module SVG
  def self.rect(center_x, center_y, width, height, fill, stroke, stroke_width)
    "<rect x=\"#{center_x}\" y=\"#{center_y}\"
      width=\"#{width}\" height=\"#{height}\"
      fill=\"#{fill}\" stroke=\"#{stroke}\" stroke-width=\"#{stroke_width}\" />"
  end

  def self.text(center_x, center_y, font_family, font_size, fill, message)
    "<text x=\"#{center_x + 6}\" y=\"#{center_y + 4}\"
      font-family=\"#{font_family}\" font-size=\"#{font_size}\"
      fill=\"#{fill}\" >#{message}</text>"
  end

  def self.line(x1, y1, x2, y2, stroke, stroke_width)
    "<line x1=\"#{x1}\" y1=\"#{y1}\" x2=\"#{x2}\" y2=\"#{y2}\" stroke=\"#{stroke}\" stroke-width=\"#{stroke_width}\" />"
  end

  def self.polyline(fill, stroke, stroke_width, points)
    "<polyline fill=\"#{fill}\" stroke=\"#{stroke}\" stroke-width=\"#{stroke_width}\" points = \"#{points.join(' ')}\" />"
  end
end


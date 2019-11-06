module SVG
  def self.rect(center_x, center_y, width, height, fill, stroke, stroke_width)
    "<rect x=\"#{center_x}\" y=\"#{center_y}\"
      width=\"#{width}\" height=\"#{height}\"
      fill=\"#{fill}\" stroke=\"#{stroke}\" stroke-width=\"#{stroke_width}\" />"
  end
end


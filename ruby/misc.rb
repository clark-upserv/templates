# writing text onto an image
m = MiniMagick::Image.open("some.png")
m.combine_options do |c|
  #c.annotate '0,0', "'some text'" (same result?)
  #c.label "some text" (same result?)
  #c.caption "'some text'" (same result?)
  c.draw "text 0, 0 '#{print}'"
  c.gravity 'Center'
  c.stroke('#000000')
  c.strokewidth 1
  c.fill('#000000')
  c.size "1000x333"
end
m.write("some.png")

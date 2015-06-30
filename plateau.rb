class Plateau

  attr_reader :x_min
  attr_reader :y_min
  attr_reader :x_max
  attr_reader :y_max

  def initialize(x_min,y_min,x_max,y_max)
    @x_min = x_min
    @y_min = y_min
    @x_max = x_max
    @y_max = y_max
  end
end

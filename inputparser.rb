#testing:done
require_relative('exceptions')
class InputParser
  def self.get_coordinates(input)
    raise InvalidInputError,'Coordinates must be positive integers' if input[/^(\d*\s\d*)$/] != input
    x_max,y_max = input.split(' ')
    x_max = x_max.to_i
    y_max = y_max.to_i
    return x_max,y_max
  end
  
  def self.get_rover_location(input)
    raise InvalidInputError,'Coordinates must be positive integers and direction must be a string' if input[/^(\d*\s\d*\s\w)$/]!=input
    x,y,direction = input.split(' ')
    raise InvalidInputError,'Direction should be E, W, N or S' if direction[/^[EWNS]$/]!=direction
    x = x.to_i
    y = y.to_i
    return x,y,direction
  end
end
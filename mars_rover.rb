require "test/unit/assertions"
include Test::Unit::Assertions

class InvalidInputError < StandardError
end

class Rectangle

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
class InvalidInputError < StandardError
end
class Rover

  attr_reader :x
  attr_reader :y
  attr_reader :direction

  def initialize(x,y,direction)
    #Check if the input is in proper format
    raise InvalidInputError if not x.is_a?(Integer)
    raise InvalidInputError if not y.is_a?(Integer)
    raise InvalidInputError if not direction.is_a?(String)
    raise InvalidInputError if direction[/^[EWNS]$/]!=direction
    
    @cardinal_directions = ['W','N','E','S']
    @x = x
    @y = y
    @direction = direction
    @direction_index = @cardinal_directions.index(direction) 
  end

  def command(s,rectangle)
    raise InvalidInputError if s[/^[LRM]*$/]!=s
    for i in 0...s.size
      if s[i]=='L' or s[i]=='R'
	change_direction(s[i])
      elsif s[i]=='M'
        move(rectangle)
      ## Debugging
      # else
      #   puts "invalid input char detected!!"
      end 
    end	
  end

  def move(rectangle)
    move_hash = {W: [-1,0],  E: [1,0],  N: [0,1], S: [0,-1]} 
    move_by = move_hash[@direction.to_sym]
    if ( (@x + move_by[0] >= rectangle.x_min) and (@x + move_by[0] <= rectangle.x_max) and (@y+move_by[1] >=rectangle.y_min) and (@y + move_by[1]<=rectangle.y_max) )
       @x += move_by[0]
       @y += move_by[1]
    end
    #puts "Rover moved to #{x},#{y}"
  end

  def change_direction(x)
    if x=='L'
        sign = - 1
    elsif x == 'R'
        sign = 1
    end
    @direction_index = (@direction_index + sign )%4
    @direction = @cardinal_directions[@direction_index]  
    #puts "Direction changed to #{@direction}"
 end
 def inspect
   "#{@x} #{@y} #{@direction}"
 end
end

class InputParser
  def self.get_coordinates(input)
    raise InvalidInputError if input[/^(\d\s\d)$/] != input
    x_max,y_max = input.split(' ')
    raise InvalidInputError if x_max[/^\d*$/]!=x_max or y_max[/^\d*$/]!=y_max
    x_max = x_max.to_i
    y_max = y_max.to_i
    return x_max,y_max
  end
  
  def self.get_rover_location(input)
    raise InvalidInputError if input[/^(\d\s\d\s\w)$/]!=input
    x,y,direction = input.split(' ')
    raise InvalidInputError if (((x[/^\d*$/]!=x) or (y[/^\d*$/]!=y)) or (direction[/^[EWNS]$/]!=direction))
    x = x.to_i
    y = y.to_i
    return x,y,direction
  end
end

class MoveRover
  def initialize
    input = gets.chomp
    x_max,y_max = InputParser.get_coordinates(input)
    rect = Rectangle.new(0,0,x_max,y_max)
    input = gets.chomp
    while true
      x,y,direction = InputParser.get_rover_location(input)
      rover = Rover.new(x,y,direction)
      command_str = gets.chomp
      rover.command(command_str,rect)
      puts "#{rover.x} #{rover.y} #{rover.direction}"  
      input = gets.chomp
      if input==""
        break
      end
    end 
  end  
end  
#MoveRover.new
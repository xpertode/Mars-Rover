require_relative('inputparser')
require_relative('plateau')
require_relative('rover.rb')

class MoveRover
  def initialize
    input = gets.chomp
    x_max,y_max = InputParser.get_coordinates(input)
    plateau = Plateau.new(0,0,x_max,y_max)
    input = gets.chomp
    while true
      x,y,direction = InputParser.get_rover_location(input)
      rover = Rover.new(x,y,direction,plateau)
      command_str = gets.chomp
      rover.command(command_str,plateau)
      puts "#{rover.x} #{rover.y} #{rover.direction}"  
      input = gets.chomp
      if input==""
        break
      end
    end 
  end  
end
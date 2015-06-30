require_relative('exceptions')
class Rover

  attr_reader :x
  attr_reader :y
  attr_reader :direction

  def initialize(x,y,direction,plateau)
    #Validate the input
    raise BoundaryError,"Rover can't go outside plateau" if (( x<plateau.x_min) or (x>plateau.x_max) or (y<plateau.y_min) or (y>plateau.y_max) )
    @cardinal_directions = ['W','N','E','S']
    @x = x
    @y = y  
    @direction = direction
    @direction_index = @cardinal_directions.index(direction) 
  end

  def command(s,plateau)
    raise InvalidCommandError,"Command can be L,R or M for left,right and move respectively" if s[/^[LRM]*$/]!=s
    for i in 0...s.size
      if s[i]=='L' or s[i]=='R'
        change_direction(s[i])
      elsif s[i]=='M'
        move(plateau)
      end 
    end	
  end

  def move(plateau)
    move_hash = {W: [-1,0],  E: [1,0],  N: [0,1], S: [0,-1]} 
    move_by = move_hash[@direction.to_sym]
    if ( (@x + move_by[0] >= plateau.x_min) and (@x + move_by[0] <= plateau.x_max) and (@y+move_by[1] >=plateau.y_min) and (@y + move_by[1]<=plateau.y_max) )
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

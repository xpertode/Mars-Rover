require_relative 'main'
require_relative 'inputparser'
require_relative 'plateau'

require 'minitest/autorun'

class TestInputParser <  MiniTest::Unit::TestCase
     
      def test_case_1()
        assert_equal [2,3],InputParser.get_coordinates("2 3")
      end
      
      def test_case_2()
        assert_equal [23,34],InputParser.get_coordinates("23 34")
      end
      
      def test_case_3()
        assert_equal [12,42,'E'],InputParser.get_rover_location("12 42 E")
      end
      
      assert_raise InvalidInputError do
        InputParser.get_coordinates("55")
      end 
      
      assert_raise InvalidInputError do
        InputParser.get_coordinates("5 w")
      end           
      
      assert_raise InvalidInputError do
        InputParser.get_coordinates("SD w")
      end 
      
      assert_raise InvalidInputError do
        InputParser.get_coordinates("5 4 6")
      end 
      
      assert_raise InvalidInputError do
        InputParser.get_coordinates("-5 4")
      end
      
      assert_raise InvalidInputError do
        InputParser.get_rover_location("1 3 C")
      end 
      
      assert_raise InvalidInputError do
        InputParser.get_rover_location("1 3 SDJ")
      end 
      
      assert_raise InvalidInputError do
        InputParser.get_rover_location("S2 G")
      end 
end

class TestPlateau <  MiniTest::Unit::TestCase
  
  def test_case_1()
    p = Plateau.new(0,0,12,43)
    assert_equal 0,p.x_min
    assert_equal 0,p.y_min
    assert_equal 12,p.x_max
    assert_equal 43,p.y_max
  end
end


class TestRover < MiniTest::Unit::TestCase
  
  def test_init_case_1
    assert_raise BoundaryError do
      Rover.new(20,5,'E',Plateau.new(0,0,10,10))
    end
  end
  
  def test_init_case_2
    r = Rover.new(10,5,'E',Plateau.new(0,0,10,10))
    assert_equal "10 5 E",r.inspect 
  end
   
  def test_command_case_1
     p = Plateau.new(0,0,10,10)
     r = Rover.new(10,5,'E',p)
     assert_raise InvalidCommandError do
       r.command("EWSD",p)
     end
  end
  
  def test_command_case_2
     p = Plateau.new(0,0,10,10)
     r = Rover.new(10,5,'E',p)
     r.command("L",p)
     assert_equal '10 5 N',r.inspect
  end
  
  def test_command_case_3
     p = Plateau.new(0,0,15,15)
     r = Rover.new(10,5,'W',p)
     r.command("M",p)
     assert_equal '9 5 W',r.inspect
  end 
   
  def test_move_case_1
    p=Plateau.new(0,0,5,5)
    r = Rover.new(1,2,'S',p)
    r.move(p)
    assert_equal "1 1 S",r.inspect
  end
   
  def test_move_case_2 
    p = Plateau.new(0,0,5,5) 
    r = Rover.new(0,0,'S',p)
    r.move(p)
    assert_equal "0 0 S",r.inspect
  end
   
  def test_case_1()    
    p = Plateau.new(0,0,5,5)
    r = Rover.new(1,2,'N',p)
    r.command('LMLMLMLMM',p)
    assert_equal "1 3 N",r.inspect
  end
   
  def test_case_2()
    p = Plateau.new(0,0,5,5)
    r = Rover.new(3,3,'E',p)
    r.command('MMRMMRMRRM',p)
    assert_equal "5 1 E",r.inspect
  end
    
  def test_case_3()
    p = Plateau.new(0,0,5,5)
    r = Rover.new(0,0,'E',p)
    r.command('MMMMMMM',p)
    assert_equal "5 0 E",r.inspect
  end 
   
  def test_case_4()
    p = Plateau.new(0,0,5,5)
    r = Rover.new(3,3,'E',p)
    r.command('RLRLRLRLRL',p)
    assert_equal "3 3 E",r.inspect
  end
   
  def test_case_5()
    p = Plateau.new(0,0,5,5)
    r = Rover.new(2,5,'E',p)
    r.command('MMMMML',p)
    assert_equal "5 5 N",r.inspect
  end

end
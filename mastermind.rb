module Mastermind
  class Player
    def initialize(name, role)
      @name, @role = name, role
    end
  end

  class Computer < Player

  end

  class Board
    def initialize(code)
      @code = code
    end
  end

  class Game
    def new_game()
      
    end
  end 
end
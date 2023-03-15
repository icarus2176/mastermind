module Mastermind
  class Player
    def initialize(name, is_guesser)
      @name, @is_guesser = name, is_guesser
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
      puts "Do you want to make the code (1) or guess the code (2)? Type the number then press enter."
      player_role = gets.chomp
      
      if player_role == 1
        player = Player.new("Player", false)
        computer = Computer.new("Computer", true)
      elsif player_role = 2
        player = Player.new("Player", true)
        computer = Computer.new("Computer", false)
      end
    end
  end 
end
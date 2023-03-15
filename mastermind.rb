module Mastermind
  class Player
    def initialize(name, is_guesser)
      @name, @is_guesser = name, is_guesser
    end

    def guess
      puts " Type your guess of 4 pins then press enter. " +
      "Colors are R, B, Y, G, P, O. Type without spaces."
      guess =  gets.chomp.split("")
    end
  end

  class Computer < Player
    def create_code
      @code = array.new()

      4.times do
        code.push(rand(5))
      end
      code
    end
  end

  class Board
    colors = ["R", "B", "Y", "G", "P", "O"]
    def initialize(code)
      @code = code
    end

    def check_answer(guess)
      result = Array.new

      guess.each_with_index do |pin, index|
        if pin == @code[index]
          result.push("C")
        elsif @code.any?(pin)
          result.push("W")
        else
          result.push("X")
        end
      end

        result
    end
  end

  class Game
    def new_game()
      puts "Do you want to make the code (1) or guess the code (2)? Type the number then press enter."
      player_role = gets.chomp
      turn_count = 1

      if player_role == 1
        @player = Player.new("Player", false)
        @computer = Computer.new("Computer", true)
      elsif player_role = 2
        @player = Player.new("Player", true)
        @computer = Computer.new("Computer", false)

        @board = Board.new(@computer.create_code)

        until(turn_count > 12)
          result = check_answer(@player.guess)
          if result.all?("C")
            win
          end
        end
      end
    end

    def win
    
    end
  end 
end
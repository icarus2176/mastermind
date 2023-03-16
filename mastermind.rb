module Mastermind
  class Player

    def guess
      puts "Type your guess of 4 pins then press enter. " +
      "Colors are R, B, Y, G, P, O. Type without spaces."
      guess =  gets.chomp.split("")
    end

    def create_code
      puts "Type your code of 4 pins then press enter. " +
      "Colors are R, B, Y, G, P, O. Type without spaces."
      code =  gets.chomp.split("")
    end
  end

  class Computer < Player
    def initialize
      @colors = ["R", "B", "Y", "G", "P", "O"]
      @previous_guess = Array.new
    end

    def guess(previous_result)
      right_color = Array.new
      guess = Array.new(4)

      previous_result.each_with_index do |pin, index|
        if pin == "W"
          right_color.push(@previous_guess[index])
        end
      end

      previous_result.each_with_index do |pin, index|
        if pin == "C"
          guess[index] = @previous_guess[index]
        elsif pin == "W"
          guess[index] = @colors.sample
        else
          if right_color[0]
            guess[index] = right_color[0]
            right_color.shift
          else
            guess[index] = @colors.sample
          end
        end
      end
      @previous_guess = guess
      guess
    end
    def create_code
      @code = Array.new()

      4.times do
        color = @colors.sample
        @code.push(color)
      end
      @code
    end
  end

  class Board
    def initialize(code)
      @code = code
    end

    def check_answer(guess)
      changed_code =  Array.new

      @code.each do |pin|
        changed_code.push(pin) 
      end

      result = Array.new(4, "x")

      guess.each_with_index do |pin, index|
        if pin == @code[index]
          result[index] = "C"
          changed_code.slice!(changed_code.index(pin))
        end
      end


      guess.each_with_index do |pin, index|
        if changed_code.any?(pin)
          result[index] = "W"
          changed_code.slice!(changed_code.index(pin))
        end
      end
        display(result)
        result
    end

    private

    def display(result)
      puts "1) #{result[0]} 2) #{result[1]} 3) #{result[2]} 4) #{result[3]}"
    end
  end

  class Game
    def new_game()
      puts "Do you want to make the code (1) or guess the code (2)? Type the number then press enter."
      @player_role = gets.chomp.to_i
      turn_count = 1
      @player = Player.new()
      @computer = Computer.new()

      if @player_role == 1
        @board = Board.new(@player.create_code)
        result = Array.new(4, "x")
        until(turn_count > 12)
          result = @board.check_answer(@computer.guess(result))
          if result.all?("C")
            lose
          end
          turn_count += 1
        end
        win
      elsif @player_role == 2
        @board = Board.new(@computer.create_code)

        until(turn_count > 12)
          result = @board.check_answer(@player.guess)
          if result.all?("C")
            win
          end
          turn_count += 1
        end
        lose
      end
    end

    def win
      if @player_role == 1
      puts "Computer couldn't guess the code. You win!"
      elsif @player_role == 2
        puts "You guessed the code! You win!"
      end

      play_again
    end

    def lose
      if @player_role == 1
        puts "Computer guessed the code. You lose."
      elsif @player_role == 2
        puts "You ran out of guesses. You lose."
      end

      play_again
    end
  
  def play_again
    puts "Do you want to play again? Y/N"
    answer = gets.chomp

    if answer == "Y"
      new_game
    end 
  end
  end
  game = Game.new
  game.new_game
end

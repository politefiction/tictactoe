class TicTacBoard
	@@a = ["_", "_", "_"]
	@@b = ["_", "_", "_"]
	@@c = ["_", "_", "_"]
	@@victory = false

	# For diagonals and columns
	def self.set_nonrows
		@@col1 = [@@a[0], @@b[0], @@c[0]]
		@@col1 = [@@a[0], @@b[0], @@c[0]]
		@@col2 = [@@a[1], @@b[1], @@c[1]]
		@@col3 = [@@a[2], @@b[2], @@c[2]]
		@@diag1 = [@@a[0], @@b[1], @@c[2]]
		@@diag2 = [@@c[0], @@b[1], @@a[2]]
	end


	def self.print_board
		puts
		puts "  1 2 3"
		puts "A " + @@a.join(" ")
		puts "B " + @@b.join(" ")
		puts "C " + @@c.join(" ")
		puts
	end

	def is_empty?(square)
		if square == "_"
			true
		else
			puts "Sorry, square taken. Please try again."
		end
	end

	# First victory method for TicTacBoard class
	def self.check_victory
		TicTacBoard.set_nonrows
		vic_array = [@@a, @@b, @@c, @@col1, @@col2, @@col3, @@diag1, @@diag2]
		vic_array.each { |arr| (@@victory = true if arr.min == arr.max) unless arr.include? "_" }
	end
	

end

class Player < TicTacBoard
	attr_accessor :player_id, :letter
	@@playercount = 0
	@@current_turn = "X"
	@@turns = 9
	def initialize(letter)
		@@playercount += 1
		@player_id = "Player #{@@playercount}"
		@letter = letter
	end

	# Second victory method for instances of Player class
	def victory?
		TicTacBoard.check_victory
		if @@victory
			TicTacBoard.print_board
			puts "Game over! #{player_id} wins!"
			exit
		end
	end

	def turn
		TicTacBoard.print_board
		puts "#{@player_id}'s turn. Choose a square (e.g., A1, B2): "
		place = gets.chomp

		if place[1].nil? or place[1].to_i < 1 or place[1].to_i > 3
			puts "Please enter a row (A, B, or C) and a column (1, 2, or 3)."
			turn
		else
			column = (place[1].to_i) - 1
			case place[0].downcase
				when "a"
					is_empty?(@@a[column]) ? @@a[column] = @letter : turn
				when "b"
					is_empty?(@@b[column]) ? @@b[column] = @letter : turn
				when "c"
					is_empty?(@@c[column]) ? @@c[column] = @letter : turn
				else
					puts "Square does not exist. Please try again."
					turn
			end
		end
	end

	def self.game(p1, p2)
		puts "Starting TicTacToe!"
		while @@turns > 0
			if @@current_turn == "X"
				p1.turn
				p1.victory?
				@@turns -= 1
				@@current_turn = "O"
			else
				p2.turn
				p2.victory?
				@@turns -=1
				@@current_turn = "X"
			end
		end
		TicTacBoard.print_board
		puts "Game Over! Nobody wins!"
	end
end


player1 = Player.new("X")
player2 = Player.new("O")

Player.game(player1, player2)

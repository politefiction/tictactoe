class TicTacBoard
	attr_accessor :a, :b, :c, :victory

	def initialize
		@a = ["_", "_", "_"]
		@b = ["_", "_", "_"]
		@c = ["_", "_", "_"]
		@victory = false
	end

	# For diagonals and columns
	def set_nonrows
		@col1 = [@a[0], @b[0], @c[0]]
		@col1 = [@a[0], @b[0], @c[0]]
		@col2 = [@a[1], @b[1], @c[1]]
		@col3 = [@a[2], @b[2], @c[2]]
		@diag1 = [@a[0], @b[1], @c[2]]
		@diag2 = [@c[0], @b[1], @a[2]]
	end


	def print_board
		puts
		puts "  1 2 3"
		puts "A " + @a.join(" ")
		puts "B " + @b.join(" ")
		puts "C " + @c.join(" ")
		puts
	end

	# First victory method, for instances of TicTacBoard class
	def check_victory
		set_nonrows
		vic_array = [@a, @b, @c, @col1, @col2, @col3, @diag1, @diag2]
		vic_array.each { |arr| (@victory = true if arr.min == arr.max) unless arr.include? "_" }
	end
	
end

class Player < TicTacBoard
	attr_accessor :player_id, :letter, :board

	@@board = TicTacBoard.new
	@@playercount = 0
	@@current_turn = "X"
	@@turns = 9

	def initialize(letter)
		@@playercount += 1
		@player_id = "Player #{@@playercount}"
		@letter = letter
		@board = @@board
	end

	# For testing purposes
	def match_classboard
		@board = @@board
	end

	def is_empty?(square)
		square == "_" ? true : (puts "Sorry, that square is taken. Please try again.")
	end

	# Second victory method, for instances of Player class
	def victory?
		@@board.check_victory
		if @@board.victory
			@@board.print_board
			puts "Game over! #{player_id} wins!"
			exit
		end
	end

	def turn
		@@board.print_board
		puts "#{@player_id}'s turn. Choose a square (e.g., A1, B2): "
		placement = gets.chomp
		fill_square(placement) { turn }
		match_classboard
	end

	# Using yield mostly for testing purposes
	def fill_square(placement)
		if placement[1].nil? or placement[1].to_i < 1 or placement[1].to_i > 3
			puts "Square does not exist. Please enter a row (A, B, or C) and a column (1, 2, or 3)."
			yield
		else
			column = (placement[1].to_i) - 1
			case placement[0].downcase
				when "a"
					is_empty?(@@board.a[column]) ? @@board.a[column] = @letter : yield
				when "b"
					is_empty?(@@board.b[column]) ? @@board.b[column] = @letter : yield
				when "c"
					is_empty?(@@board.c[column]) ? @@board.c[column] = @letter : yield
				else
					puts "Square does not exist. Please enter a row (A, B, or C) and a column (1, 2, or 3)."
					yield
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
		@@board.print_board
		puts "Game Over! Nobody wins!"
	end
end


#player1 = Player.new("X")
#player2 = Player.new("O")

#Player.game(player1, player2)
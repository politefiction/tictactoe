class TicTacBoard
	@@a = ["_", "_", "_"]
	@@b = ["_", "_", "_"]
	@@c = ["_", "_", "_"]
	@@col1 = [@@a[0], @@b[0], @@c[0]]
	@@col2 = [@@a[1], @@b[1], @@c[1]]
	@@col3 = [@@a[2], @@b[2], @@c[2]]
	@@diag1 = [@@a[0], @@b[1], @@c[2]]
	@@diag2 = [@@c[0], @@b[1], @@a[2]]
	@@victory = false

	def self.print_board
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
			puts "Sorry, square taken."
			turn
		end
	end

	def self.check_victory
		vic_array = [@@a, @@b, @@c, @@col1, @@col2, @@col3, @@diag1, @@diag2]
		vic_array.each do |arr|
			unless arr.include? "_"
				if arr.min == arr.max
					@@victory = true
				end
			end
		end
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

	def victory?
		TicTacBoard.check_victory
		if @@victory
			puts "Game over! #{player_id} wins!"
			exit
		end
	end

	def turn
		puts "#{@player_id}'s turn. Choose a square (e.g., A1, B2): "
		place = gets.chomp

		column = (place[1].to_i) - 1
		case
			when place[0].downcase == "a"
				@@a[column] = @letter if is_empty?(@@a[column])
			when place[0].downcase == "b"
				@@b[column] = @letter if is_empty?(@@b[column])
			when place[0].downcase == "c"
				@@c[column] = @letter if is_empty?(@@c[column])
			else
				puts "Nope. Please try again."
				turn
		end
		TicTacBoard.print_board
	end

	def self.game(p1, p2)
		if p1.class != Player or p2.class != Player
			puts "Wait a minute! This game needs two players!"
		else
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
		end
		puts "Game Over! Nobody wins!"
	end
end


TicTacBoard.print_board
player1 = Player.new("X")
player2 = Player.new("O")

Player.game(player1, player2)


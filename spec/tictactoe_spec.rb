require 'tictactoe'

# Mocks/doubles to be added later
# Will also attempt to clean up existing tests

describe 'TicTacBoard' do
	let(:board) { TicTacBoard.new }

	describe '#check_victory' do
		context 'matching letters in top row' do
			before do 
				board.a = ["X", "X", "X"]
				board.check_victory
			end
			it 'should set #victory to true' do
				expect(board.victory).to be true
			end
		end

		context 'varying letters in top row' do
			before do 
				board.a = ["X", "O", "X"]
				board.check_victory
			end
			it 'should not set #victory to true' do
				expect(board.victory).to be false
			end
		end

		context 'matching letters in column' do
			before do
				board.a[1] = "O"
				board.b[1] = "O"
				board.c[1] = "O"
				board.check_victory
			end
			it 'should set #victory to true' do
				expect(board.victory).to be true
			end
		end

		context 'matching letters in diagonal' do
			before do
				board.a[0] = "X"
				board.b[1] = "X"
				board.c[2] = "X"
				board.check_victory
			end
			it 'should set #victory to true' do
				expect(board.victory).to be true
			end
		end
	end
end

describe 'Player' do
	let(:player_one) { Player.new("X") }
	let(:player_two) { Player.new("O") }

	describe '#turn' do
		context 'player_one chooses square A1' do
			before do 
				$stdin = StringIO.new("a1\n")
				player_one.turn
			end
			after do
				$stdin = STDIN
			end
			it 'places an "X" on A1' do
				expect(player_one.board.a[0]).to eq("X")
			end
		end

		context 'player_two chooses square C2' do
			before do 
				$stdin = StringIO.new("c2\n")
				player_two.turn 
			end
			after do
				$stdin = STDIN
			end
			it 'places an "O" on C2' do
				expect(player_two.board.c[1]).to eq("O")
			end
		end
	end

	describe '#is_empty?' do
		context 'square contains a letter' do
			before { player_one.board.a[0] = "X" }
			it 'should not show square as empty' do 
				expect(player_one.is_empty? player_one.board.a[0]).not_to be true
			end
		end

		context 'square is empty' do
			it 'should show square as empty' do 
				expect(player_one.is_empty? player_one.board.a[1]).to be true
			end
		end
	end

	describe '#fill_square' do
		context 'player picks square that does not exist' do
			msg = "Square does not exist. Please try again."
			it 'tells the player to try again' do
				expect(player_one.fill_square("a7") { msg }).to eq(msg)
			end
		end

		context 'player chooses unavailable square' do
			msg = "Square is taken. Please try again."
			before { player_one.board.b[1] = "X" }
			it 'tells the player to try again' do
				expect(player_one.fill_square("b2") { msg }).to eq(msg)
			end
		end

		context 'player only enters one character' do
			msg = "Two-character response needed. Please try again."
			it 'tells the player to try again' do
				expect(player_one.fill_square("a") { msg }).to eq(msg)
			end
		end

		context 'player enters square correctly' do
			msg = "Hmm. You're not supposed to see this."
			it 'fills in the square' do
				expect(player_one.fill_square("b3") { msg }).to eq("X")
			end
		end
	end
end


=begin 

=end
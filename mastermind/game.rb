module Mastermind
	class Game
		attr_reader :peg_colors, :board
		def initialize()
			@peg_colors = ['red','blue','green','yellow','purple','orange']
			@board = Board.new(generate_pattern)
		end

		def play
			puts ""
			puts "Welcome to Mastermind"
			puts "You have twelve turns to correctly guess the master code"
			turns = 0
			while turns < 12
				solict_move
				guess = get_guess([])
				puts ""
				puts "You have entered: " + guess.join(" ")
				board.add_entry(guess)
				feedback = board.feedback
				puts "Correct colors and positions: " + feedback[0].to_s
				puts "Correct colors: " + feedback[1].to_s
				if board.game_over
					break
				else
					turns = turns + 1
					puts (12-turns).to_s + " turns left"
					puts ''
				end
			end
			puts
			game_over_message(turns)
			puts "The correct code was " + board.show_pattern.join(" ")
			puts
		end


		def solict_move
			puts "Valid Colors are: " + peg_colors.join(" ")
			puts "Enter a color: "
		end

		def get_guess(guess_array)
			while (guess_array.length < 4) do 
				color = gets.chomp.downcase
				if is_valid_color?(color)
					guess_array << color
					puts "The color: " + color +" has been entered"
				else
					puts "That is not a valid color. Please try again."
				end
			end
			return guess_array
		end

		def game_over_message(turns)
			if turns < 12
				puts "Congratulations! You won in: " + turns.to_s + " turns"
			else
				puts "Game Over! You are out of turns."
			end
		end

		def generate_pattern
			pattern = [] 
			4.times do
				num = rand(6)
				pattern<<peg_colors[num]
			end
			return pattern
		end
		
		def is_valid_color?(color)
			return peg_colors.include?(color)
		end
	end
end

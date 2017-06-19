module Mastermind
	class Board
		attr_accessor :grid, :pattern_hash
		def initialize(pattern)
			@grid = default_grid.push(pattern)
			@pattern_hash = set_pattern_hash(pattern)
		end

		#white = correct color
		#black = correct color and correct position
		def check_guess(guess)
			guess_hash = count_colors(guess)
			white = compare_colors(pattern_hash,guess_hash)
			black = compare_positions(grid[0],guess)
			if black > 0
				white = white - black
			end
			return [black,white]
		end

		def add_entry(guess)
			grid.push([guess,check_guess(guess)])
		end

		def set_pattern_hash(pattern)
			return count_colors(pattern)
		end

		def feedback
			return grid[-1][-1]
		end

		def show_pattern
			return grid[0]
		end
		def count_colors(array)
			hash = Hash.new
			array.each do |element|
				if hash.has_key?(element)
					hash[element] = hash[element] + 1
				else
					hash[element] = 1
				end
			end
			return hash
		end

		#number of correct colors
		def compare_colors(phash,ghash)
			same_colors = 0
			ghash.each do |key,value|
				if phash.key?(key) 
					if phash[key] <= value
						same_colors = same_colors + phash[key]
					else
						same_colors = same_colors + value
					end
				end
			end
			return same_colors
		end

		def compare_positions(parray,garray)
			correct = 0
			parray.each_with_index do |value,index|
				if garray[index] == value
					correct = correct + 1
				end
			end
			return correct
		end

		def game_over
			return winner?
		end

		private
		def default_grid
			return Array.new()
		end

		def winner?
			if grid[-1][-1][0] == grid[0].length
				return true
			else
				return false
			end
		end
	end
end
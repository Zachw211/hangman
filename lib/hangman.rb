require "yaml"

class Dictionary

	def initialize
		@all_words = File.readlines "5desk.txt"
		@words = []
	end

	def get_words
		@all_words.each do |word|
			if word.length > 5 && word.length < 13
				@words << word
			end
		end
	end

end

class Hangman

	def initialize
		@words = Dictionary.new.get_words
		@secret_word = ""
		@guess_word = []
		@guessed_letters = []
		@chances = 10
		@playing = true
		@hanged = false
		@win = false
		@saves = 0
	end

	def game_loop
		while @playing
			save_or_load
			get_guess
			check_guess
			display_guess
			puts @secret_word
			game_check
			game_over	
		end
	end
					
	def game_check
		win_check
		if @chances == 0
			@playing = false
			@hanged = true
		end
	end

	def all_letters(word)
		word[/[a-zA-Z]+/] == word
	end

	def win_check
		word = @guess_word.join("")
		all_letters(word) ? @playing = false : @playing = true
	end

	def game_over
		if !@playing
			if @hanged
				lose_message
			else
				win_message
			end
		end
	end
	
	def lose_message
		puts "You have been hanged."
		puts "The correct word was #{@secret_word}"
		puts "Play again(y/n)"
		if gets.chomp == "y"
			game = Hangman.new
			game.play
		else
			puts "Thanks for playing"
		end

	end

	def win_message
		puts "Way to go! You won!"
		puts "Play again(y/n)"
		if gets.chomp == "y"
			game = Hangman.new
			game.play
		else
			puts "Thanks for playing."
		end
	end

	def get_guess
		puts "Guess a letter."
		puts "You have already guessed: #{@guessed_letters.join(", ")}"
		@letter = gets.chomp.downcase
		if @guessed_letters.include?(@letter)
			puts "You have already guessed this letter. Guess again."
			get_guess
		end
		@guessed_letters << @letter
	end

	def get_secret_word
		@secret_word = @words[rand(1..48891)].downcase
	end

	def	create_guess
		@guess_length = @secret_word.length-1
		@guess_length.times {@guess_word << "_"}

	end

	def check_guess
		@secret_letters = @secret_word.split("")
		if @secret_letters.include?(@letter)
			@secret_letters.each_with_index do |letter, index|
				if letter == @letter
					@guess_word[index] = @letter
				end
			end
		else
			@chances -= 1
			puts "I'm sorry, that letter is not in the secret word."
			puts "You have #{@chances} guesses left."
		end
	end

	def display_guess
		puts @guess_word.join(" ")

	end

	def save_game
		Dir.mkdir("save") unless Dir.exists?("save")
		save_file = File.new("save/hangman_#{@saves}.yaml", "w")
		save_file.write(YAML.dump([@secret_word, @guess_word, @guessed_letters, @chances]))
		@saves += 1
		save_file.close
	end

	def load_game(number)
		file = File.new("save/hangman_#{number}.yaml", "r")
		save_file = file.read
		file.close
		File.delete("save/hangman_#{number}.yaml")

		data = YAML::load(save_file)

		@secret_word = data[0]
		@guess_word = data[1]
		@guessed_letters = data[2]
		@chances = data[3]
	end

	def start
		choice = ""
		puts "Would you like to start a new game or load a previous save?(new/load)"
		choice = gets.chomp.downcase
		if choice == "load"
			puts "Which save would you like to restore?"
			puts Dir.new("save").entries
			number = gets.chomp.to_i
			load_game(number)
		else
			get_secret_word
			create_guess
			display_guess
		end
	end

	def save_or_load
		choice = ""
		puts "Would you like to save the current game or load a previous save?(y/n)"
		choice = gets.chomp.downcase
		if choice == "y"
			puts "Save or load?"
			choice = gets.chomp.downcase

			if choice == "save"
				save_game
				puts "Game saved"
			else
				puts "Which save would you like to restore?"
				puts Dir.new("save").entries
				number = gets.chomp.to_i
				load_game(number)
			end
		end
	end
	def play
		start
		game_loop
	end



end

test = Hangman.new
test.play
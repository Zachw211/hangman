class Hangman

	def initialize
		@all_words = File.readlines "5desk.txt"
		@words = []
		@secret_word = ""
		@guess_word = []
		@guess = 0
		@guessed_letters = []
		@chances = 10
		@playing = true
		@hanged = false
		@win = false
	end

	def game_loop
		while @playing
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
		puts "Play again(y/n)"
		if gets.chomp == "y"
			game = Hangman.new
			game.play
		end

	end

	def win_message
		puts "Way to go! You won!"
		puts "Play again(y/n)"
		if gets.chomp == "y"
			game = Hangman.new
			game.play
		end
	end

	def get_words
		@all_words.each do |word|
			if word.length > 5 && word.length < 13
				@words << word
			end
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

	def play
		get_words
		get_secret_word
		puts @secret_word
		create_guess
		display_guess
		game_loop

	end



end

test = Hangman.new
test.play
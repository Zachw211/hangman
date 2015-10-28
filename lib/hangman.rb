class Hangman

	def initialize
		@all_words = File.readlines "5desk.txt"
		@words = []
		@secret_word = ""
		@guess_word = []
		@guess = 0
		@guessed_letters = []
		@chances = 10

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
		puts "You have already guessed #{@guessed_letters}"
		@letter = gets.chomp.downcase
		@guessed_letters << @letter
	end

	def get_secret_word
		@secret_word = @words[rand(1..48891)]
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

	def test_functions
		get_words
		get_secret_word
		puts @secret_word
		create_guess
		puts @guess_word.join(" ")
		get_guess
		check_guess
		puts @guess_word.join(" ")
	end


end

test = Hangman.new
test.test_functions
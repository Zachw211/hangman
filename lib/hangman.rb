
		@all_words = File.readlines "5desk.txt"
		@words = []
		@guess = 0
		@chances = 10
		@playing = true
		@hanged = false
		@guessed_letters = []
		@letter = ""
	

	#def hanged
	#	if @guess == @chances
	#		@playing = false
	#		@hanged = true
	#	end
	#end	

	#def guess
		#while @playing

	#end

	def get_guess
		@guess += 1
		puts "Guess a letter."
		puts "You have already guessed #{@guessed_letters}"
		@letter = gets.chomp.downcase
		@guessed_letters << @letter
	end

	#get all the suitable words from 5desk and push them to words[]
	def get_words
		@all_words.each do |word|
			if word.length > 5 && word.length < 13
				@words.push word
			end
		end
	end

	#

	#run get_words
	get_words
	#get the word to be guessed from @words[]
	@secret_word = @words[rand(1..48891)]

	#create empty array to store the users guesses
	@guess_word = []

	#get the actual length of the word being guessed
	@guess_length = @secret_word.length-1

	#initialize @guess_word[] with undescores
	@guess_length.times {@guess_word << "_"}


	
	get_guess
	puts @secret_word.length
	puts @secret_word
	puts @guess_word.join(" ")
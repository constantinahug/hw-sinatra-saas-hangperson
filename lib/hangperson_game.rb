class HangpersonGame attr_accessor :word, :guesses, :wrong_guesses

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end
  
  def guess(letter)
    # Handles exceptions
    if letter.nil?
      raise ArgumentError
      elsif letter.empty?
      raise ArgumentError
    elsif /[^a-zA-Z0-9]/.match(letter)
      raise ArgumentError
    end
    
    # Handles guessing logic
    letter = letter.downcase
    if @word.include?(letter) and !@guesses.include?(letter)
      @guesses.concat(letter)
      return true
    elsif !@word.include?(letter) and !@wrong_guesses.include?(letter)
      @wrong_guesses.concat(letter)
      return true
    elsif @guesses.include?(letter) or @wrong_guesses.include?(letter)
      return false
    end
  end
  
  # This function displays the word with the letters that a user has guessed
  def word_with_guesses
    displayed_word = ""
    @word.each_char do |correct_word_letter|
      if @guesses.include?(correct_word_letter)
        displayed_word.concat(correct_word_letter)
      else
        displayed_word.concat("-")
      end
    end
    return displayed_word
  end
  
  # This function checks to see if the game is over
  def check_win_or_lose
    if wrong_guesses.length >= 7
      return :lose
    elsif @guesses.length == @word.length
      return :win
    else
      return :play
    end
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end

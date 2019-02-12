class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  attr_accessor :word , :guesses , :wrong_guesses

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def check_win_or_lose
    if word_with_guesses.downcase == @word.downcase
      return :win
    elsif @wrong_guesses.length >= 7
      return :lose
    else
      return :play
    end
  end
  
   # displays the formatted word after guesses have been made
  def word_with_guesses
    result = ''
    @word.split('').each do |char|
      if @guesses.include? char
        result << char
      else
        result << '-'
      end
    end
    
    return result
  end
  
  def guess(letter)
  
    # throws an error when empty
    if letter == nil || !(letter.class == String && letter =~ /^[A-z]$/i)
      raise ArgumentError
    end
    
    #make everything lowercase
    letter.downcase!
    
    #make a check for repeats
    if @guesses.include?(letter) || @wrong_guesses.include?(letter)
      return false
    end
    #for guesses that included
    if @word.include? letter
      @guesses << letter
    else
    #this for wrong guesses
     @wrong_guesses << letter
    end
    return true
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

require 'json'
require 'uri'
require 'net/http'
require 'open-uri'



class GamesController < ApplicationController
  def new
    alphabet = ('A'..'Z').to_a
    @letters = []
    10.times do
      @letters << alphabet.sample
    end
  end

  def score
    Time.now
    params[:start_time]
    @word      = params[:word].upcase
    word_array = @word.chars
    @letters   = params[:letters].split('')

    valid_word = word_array.all? do |char|
      @letters.count(char) >= word_array.count(char)
    end
    if valid_word
      url = "https://wagon-dictionary.herokuapp.com/#{@word}"
      result = JSON.parse(URI.open(url).read)
      correct = result['correct']
      if correct
        @message = 'Super !'
        time = (end_time - start_time.to_time) / 60
        @score = @word.length / time
      else 'You loose'
      end
    else
      "That's not a right word"
    end
  end
end

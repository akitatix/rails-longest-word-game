require "open-uri"
require "json"
class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters.push(('a'...'z').to_a.sample) }
  end

  # POST /score
  def score
    @letters = params[:letters].split(" ")
    @question = params[:question].downcase || "Nothing"
    a = @question.split("")
    b = a - @letters
    if b == []
      if english_word?(params[:question])
        @question = "Congratulation #{@question} is good and English"
      else
        @question = "Congratulation #{@question} is good but no English"
      end
    else
      @question = "Sorry #{@question} can't be build with #{@letters.join(' ')}"
    end
  end

  def english_word?(question)
  response = open("https://wagon-dictionary.herokuapp.com/#{question}")
  json = JSON.parse(response.read)
  json['found']
  end
end

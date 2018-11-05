require 'open-uri'

class GamesController < ApplicationController

  def new
    grid_size = 10
    grid_size_array = []
    for num in (1..grid_size).to_a do
      grid_size_array << ("A".."Z").to_a.sample
    end
    @letters = grid_size_array
  end

  def score
    # raise

    @message = score_and_message(params[:user_word], params[:letters])

  end

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def score_and_message(attempt, grid)
    if included?(attempt.upcase, grid)
      if english_word?(attempt)
        "well done"
      else
        "not an english word"
      end
    else
        "not in the grid"
    end
  end
end



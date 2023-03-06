require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
    session[:score] ||= 0
  end

  def score
    url = 'https://wagon-dictionary.herokuapp.com/' + params[:answer]
    reponse = URI.open(url).read
    result = JSON.parse(reponse)
    if (params[:answer].chars - params[:letters].downcase.split).size.positive?
      @to_display = "Sorry but #{params[:answer]} can't be built out of #{params[:letters]}"
      @to_display
    elsif result['found'] == false
      @to_display = "Sorry but #{params[:answer]} does not seem to be a valid english word"
    else
      @to_display = "Congratulation! #{params[:answer]} is a valid English word!"
      session[:score] += 1
    end
  end
end

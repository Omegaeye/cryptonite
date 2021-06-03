class Api::V1::CoinsController < ApplicationController
  
  def index
    @coins = Coin.all
    require 'pry'; binding.pry
    render json: CoinSerializer.new(@coins)
  end
  
end

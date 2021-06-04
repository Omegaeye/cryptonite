class Api::V1::CoinsController < ApplicationController
  
  def index
    @coins = Coin.pagination_helper(params[:page].to_i, params[:per_page].to_i)
    render json: CoinSerializer.new(@coins)
  end
end

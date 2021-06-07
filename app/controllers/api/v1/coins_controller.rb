class Api::V1::CoinsController < ApplicationController
  
  def index
    @coins = Coin.pagination_helper(params[:page], params[:per_page])
    render json: CoinSerializer.new(@coins)
  end
end

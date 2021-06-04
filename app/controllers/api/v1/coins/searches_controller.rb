class Api::V1::Coins::SearchesController < ApplicationController
   def show
        @search = Search.find(params[:id])
    end 

    def new 
        @search = Search.new
        @symbol = Coin.distinct.pluck(:symbol)
        @usd_price = Coin.distinct.pluck(:usd_price)
        @btc_price = Coin.distinct.pluck(:btc_price)
        @percent_change = Coin.distinct.pluck(:percent_change)
    end

    def create
        @search = Search.create(search_params)
        redirect_to @search
    end 

    private

    def search_params
        params.require(:search).permit(:name, :symbol, :usd_price, :btc_price, :percent_change)
    end 
end

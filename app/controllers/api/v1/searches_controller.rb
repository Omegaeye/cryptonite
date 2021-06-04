class Api::V1::SearchesController < ApplicationController
   def show
        @search = Search.find(params[:id])
    end 

    def create
        new_params = search_params
        new_params[:name] = search_params[:name].downcase if search_params[:name]
        new_params[:symbol] = search_params[:symbol].downcase if search_params[:symbol].present?
        @search = Search.create(new_params)
        render json: CoinSerializer.new(@search.search_coins)
    end 

    private

    def search_params
        params.permit(:name, :symbol, :usd_price, :btc_price, :percent_change)
    end 
end

class Api::V1::SearchesController < ApplicationController

    def create
        new_params = search_params
        new_params[:name] = search_params[:name].downcase if search_params[:name]
        new_params[:symbol] = search_params[:symbol].downcase if search_params[:symbol].present?
        @search = Search.create(new_params).search_coins
        if @search.empty?
            return no_record_found
        else
            render json: CoinSerializer.new(@search.pagination_helper(params[:page].to_i, params[:per_page].to_i))
        end
    end 

    private

    def search_params
        params.permit(:name, :symbol, :usd_price, :btc_price, :percent_change)
    end 
end

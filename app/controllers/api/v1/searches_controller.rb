class Api::V1::SearchesController < ApplicationController

    def create
        @search = Search.create(search_params).search_coins
        return no_record_found if @search.empty?
        @search = @search.pagination_helper(params[:page].to_i, params[:per_page].to_i)
        @search = @search.sorting_params(params[:sort])  if params[:sort]
        render json: CoinSerializer.new(@search)
    end 

    private

    def search_params
        old_params = params.permit(:name, :symbol, :usd_price, :btc_price, :percent_change)
        new_params = old_params
        new_params[:name] = old_params[:name].downcase if old_params[:name]
        new_params[:symbol] = old_params[:symbol].downcase if old_params[:symbol]
        new_params
    end 
end

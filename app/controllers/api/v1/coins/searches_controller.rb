class Api::V1::Coins::SearchesController < ApplicationController

    def create
        @search = Search.create(search_params)
        @search_result = Coin.search_coins(search_params)
        return no_record_found if @search_result.empty?
        @paginated_search_result = @search_result.pagination_helper(params[:page], params[:per_page])
        @paginated_search_result = @paginated_search_result.sorting_params(params[:sort])  if params[:sort]
        render json: CoinSerializer.new(@paginated_search_result)
    end 

    private

    def search_params
        old_params = params.permit(:name, :min_btc_price, :max_btc_price, :min_usd_price, :max_usd_price,  :min_percent_change, :max_percent_change, :symbol)
        new_params = old_params
        new_params[:name] = old_params[:name].downcase if old_params[:name]
        new_params[:symbol] = old_params[:symbol].downcase if old_params[:symbol]
        new_params
    end 
end

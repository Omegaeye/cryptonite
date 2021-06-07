class ShrimpyService

  def self.get_data
    response = conn.get('/v1/exchanges/kucoin/ticker')
    
    parse(response)
  end

  private

  def self.conn
    Faraday.new('https://dev-api.shrimpy.io', params: { 'x-api-key': ENV['shrimpy_api_key'] })
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
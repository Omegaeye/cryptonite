require 'rails_helper'

RSpec.describe Search, type: :model do
  describe "validations" do
   it { should validate_uniqueness_of(:name).scoped_to(:symbol, :usd_price, :btc_price, :percent_change) }
  end

  describe "test instance method" do
    it "should create an instance of search" do
      search = Search.create(name: 'itc')
      expect(search).to be_a(Search)  
    end

    it "should create an instance with multiple attributes" do
      search = Search.create(name: 'itc', usd_price: 1000).search_coins
      expect(search.first.attributes.keys).to eq(%w[id name symbol usd_price btc_price percent_change created_at updated_at])
    end
    
    it "should not create an instance of search with the same search" do
      search = Search.create(name: 'itc')
      search2 = Search.create(name: 'itc')
      expect(search2.save).to eq(false)
    end
  end
end

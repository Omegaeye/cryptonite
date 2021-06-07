require 'rails_helper'

RSpec.describe Search, type: :model do
  describe "validations" do
   it { should validate_uniqueness_of(:name).scoped_to( :min_btc_price, :max_btc_price, :min_usd_price, :max_usd_price,  :min_percent_change, :max_percent_change, :symbol) }
  end

  describe "test instance method" do
    it "should create an instance of search" do
      search = Search.create(name: 'itc')
      expect(search).to be_a(Search)  
    end
    
    it "should not create an instance of search with the same search" do
      search = Search.create(name: 'itc')
      search2 = Search.create(name: 'itc')
      expect(search2.save).to eq(false)
    end
  end
end

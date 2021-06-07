require 'rails_helper'

RSpec.describe Coin, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:symbol) }
    it { should validate_presence_of(:usd_price) }
    it { should validate_presence_of(:btc_price) }
    it { should validate_presence_of(:percent_change) }
  end

  describe "testing class methods" do
    context "happy pagination_helper" do
      it "should return correct limits and offest" do
        test = Coin.pagination_helper(1, 1)
        test2 = Coin.pagination_helper(2, 15)
        test3 = Coin.pagination_helper(3, 20)
        expect(test.size).to eq(1)
        expect(test2.size).to eq(15)
        expect(test2.first).to eq(Coin.all.take(16).last)
        expect(test3.size).to eq(20)
        expect(test3.first).to eq(Coin.all.take(41).last)
      end
    end

    context "sad path and edge case pagination_helper" do
      it "should return records even with invalid params" do
        test = Coin.pagination_helper('t', 'y')
        test2 = Coin.pagination_helper('🙁', 15)
        test3 = Coin.pagination_helper(3, '😒')
        expect(test.size).to eq(20)
        expect(test2.size).to eq(15)
        expect(test2.first).to eq(Coin.all.take(14).first)
        expect(test3.size).to eq(20)
        expect(test3.first).to eq(Coin.all.take(41).last)
      end
    end

    context 'happy path search_coins' do
      it "should return records with name params" do
        search = Coin.search_coins({name: 'bitcoin'})
        expect(search.first.attributes.keys).to eq(%w[id name symbol usd_price btc_price percent_change created_at updated_at])
        expect(search.first.name.include?('bitcoin')).to eq(true)
      end

       it "should return records with symbol params" do
        search = Coin.search_coins({symbol: 'btc'})
        expect(search.first.symbol.include?('btc')).to eq(true)
      end

      it "should returns record with min_btc_price and max_btc_price params" do
        search = Coin.search_coins({min_btc_price: 1, max_btc_price: 2}).order(btc_price: :desc)
        expect(search.first.btc_price).to be < 2
        expect(search.last.btc_price).to be > 1
        expect(search.first.btc_price).to be > search.last.btc_price
      end

      it "should returns record with min_usd_price and max_usd_price params" do
        search = Coin.search_coins({min_usd_price: 1000, max_usd_price: 50_000}).order(usd_price: :desc)
        expect(search.first.usd_price).to be < 50_000
        expect(search.last.usd_price).to be > 1000
        expect(search.first.usd_price).to be > search.last.usd_price
      end

      it "should returns record with min_percent_change and max_percent_change params" do
        search = Coin.search_coins({min_percent_change: -5, max_percent_change: 20}).order(percent_change: :desc)
        expect(search.first.percent_change).to be < 20
        expect(search.last.percent_change).to be > -5
        expect(search.first.percent_change).to be > search.last.percent_change
      end
    end

    context 'sad_path and edge case search_coins' do
      context ' sad path and edge case for name ' do
        it "should return record with partial search " do
          search = Coin.search_coins({name: 'itc'})
          expect(search.first.name.include?('itc')).to eq(true)
          expect(search.last.name.include?('itc')).to eq(true)
        end
  
         it "should default to all if name is empty" do
          search = Coin.search_coins({name: ''})
          expect(search.size).to eq(291)
        end
  
        it "should return empty array if giving integer or other data types" do
          search = Coin.search_coins({name: '😍'})
          search2 = Coin.search_coins({name: 3242432})
          search3 = Coin.search_coins({name: '?'})
          expect(search.size).to eq(0)
          expect(search2.size).to eq(0)
          expect(search3.size).to eq(0)
        end
      end

      context ' sad path and edge case for symbol ' do
        it "should return records with partial symbol params" do
        search = Coin.search_coins({symbol: 'it'})
        expect(search.first.symbol.include?('it')).to eq(true)
        expect(search.last.symbol.include?('it')).to eq(true)
      end
  
         it "should default to all if symbol is empty" do
          search = Coin.search_coins({symbol: ''})
          expect(search.size).to eq(291)
        end
  
        it "should return empty array if giving integer or other data types" do
          search = Coin.search_coins({symbol: '😍'})
          search2 = Coin.search_coins({symbol: 3242432})
          search3 = Coin.search_coins({symbol: '?'})
          expect(search.size).to eq(0)
          expect(search2.size).to eq(0)
          expect(search3.size).to eq(0)
        end
      end

      context ' sad path and edge case for min and max btc price ' do
        it "should return records with invalid min_btc_price params" do
          search = Coin.search_coins({min_btc_price: '', max_btc_price: 2}).order(btc_price: :desc)
          search2 = Coin.search_coins({min_btc_price: '😜', max_btc_price: 2}).order(btc_price: :desc)
          search3 = Coin.search_coins({min_btc_price: 'fdsafda', max_btc_price: 2}).order(btc_price: :desc)
          expect(search.first.btc_price).to be < 2
          expect(search.last.btc_price).to be > 0
          expect(search2.first.btc_price).to be < 2
          expect(search2.last.btc_price).to be > 0
          expect(search3.first.btc_price).to be < 2
          expect(search3.last.btc_price).to be > 0
        end
  
        it "should return records with invalid max_btc_price params" do
          search = Coin.search_coins({min_btc_price: 1, max_btc_price: ''}).order(btc_price: :desc)
          search2 = Coin.search_coins({min_btc_price: 1, max_btc_price: '👍🏼'}).order(btc_price: :desc)
          search3 = Coin.search_coins({min_btc_price: 1, max_btc_price: 'fdasfda'}).order(btc_price: :desc)
          expect(search.last.btc_price).to be > 1
          expect(search.first.btc_price).to be > search.last.btc_price
          expect(search2.last.btc_price).to be > 1
          expect(search2.first.btc_price).to be > search.last.btc_price
          expect(search3.last.btc_price).to be > 1
          expect(search3.first.btc_price).to be > search.last.btc_price
        end
  
        it "should return all records if params are empty or invalid" do
          search = Coin.search_coins({min_btc_price: '', max_btc_price: ''})
          search2 = Coin.search_coins({min_btc_price: '?', max_btc_price: '🙁'})
          search3 = Coin.search_coins({min_btc_price: 'fdsafda', max_btc_price: 'fesaf'})
          expect(search.size).to eq(291)
          expect(search2.size).to eq(291)
          expect(search3.size).to eq(291)
        end
      end

      context ' sad path and edge case for min and max usd price ' do
        it "should return records with invalid min_usd_price params" do
          search = Coin.search_coins({min_usd_price: '', max_usd_price: 1000}).order(usd_price: :desc)
          search2 = Coin.search_coins({min_usd_price: '😜', max_usd_price: 1000}).order(usd_price: :desc)
          search3 = Coin.search_coins({min_usd_price: 'fdsafda', max_usd_price: 1000}).order(usd_price: :desc)
          expect(search.first.usd_price).to be < 1000
          expect(search.last.usd_price).to be > 0
          expect(search2.first.usd_price).to be < 1000
          expect(search2.last.usd_price).to be > 0
          expect(search3.first.usd_price).to be < 1000
          expect(search3.last.usd_price).to be > 0
        end
  
        it "should return records with invalid max_usd_price params" do
          search = Coin.search_coins({min_usd_price: 1000, max_usd_price: ''}).order(usd_price: :desc)
          search2 = Coin.search_coins({min_usd_price: 1000, max_usd_price: '👍🏼'}).order(usd_price: :desc)
          search3 = Coin.search_coins({min_usd_price: 1000, max_usd_price: 'fdasfda'}).order(usd_price: :desc)
          expect(search.last.usd_price).to be > 1000
          expect(search.first.usd_price).to be > search.last.usd_price
          expect(search2.last.usd_price).to be > 1000
          expect(search2.first.usd_price).to be > search.last.usd_price
          expect(search3.last.usd_price).to be > 1000
          expect(search3.first.usd_price).to be > search.last.usd_price
        end
  
        it "should return all records if params are empty or invalid" do
          search = Coin.search_coins({min_usd_price: '', max_usd_price: ''})
          search2 = Coin.search_coins({min_usd_price: '?', max_usd_price: '🙁'})
          search3 = Coin.search_coins({min_usd_price: 'fdsafda', max_usd_price: 'fesaf'})
          expect(search.size).to eq(291)
          expect(search2.size).to eq(291)
          expect(search3.size).to eq(291)
        end
      end

      context ' sad path and edge case for min and max percent_change ' do
        it "should return records with invalid min_percent_change params" do
          search = Coin.search_coins({min_percent_change: '', max_percent_change: 30}).order(percent_change: :desc)
          search2 = Coin.search_coins({min_percent_change: '😜', max_percent_change: 30}).order(percent_change: :desc)
          search3 = Coin.search_coins({min_percent_change: 'fdsafda', max_percent_change: 30}).order(percent_change: :desc)
          expect(search.first.percent_change).to be < 30
          expect(search.last.percent_change).to be < search.first.percent_change
          expect(search2.first.percent_change).to be < 30
          expect(search2.last.percent_change).to be < search.first.percent_change
          expect(search3.first.percent_change).to be < 30
          expect(search3.last.percent_change).to be < search.first.percent_change
        end
  
        it "should return records with invalid max_percent_change params" do
          search = Coin.search_coins({min_percent_change: -10, max_percent_change: ''}).order(percent_change: :desc)
          search2 = Coin.search_coins({min_percent_change: -10, max_percent_change: '👍🏼'}).order(percent_change: :desc)
          search3 = Coin.search_coins({min_percent_change: -10, max_percent_change: 'fdasfda'}).order(percent_change: :desc)
          expect(search.last.percent_change).to be > -10
          expect(search.first.percent_change).to be > search.last.percent_change
          expect(search2.last.percent_change).to be > -10
          expect(search2.first.percent_change).to be > search.last.percent_change
          expect(search3.last.percent_change).to be > -10
          expect(search3.first.percent_change).to be > search.last.percent_change
        end
  
        it "should return all records if params are empty or invalid" do
          search = Coin.search_coins({min_percent_change: '', max_percent_change: ''})
          search2 = Coin.search_coins({min_percent_change: '?', max_percent_change: '🙁'})
          search3 = Coin.search_coins({min_percent_change: 'fdsafda', max_percent_change: 'fesaf'})
          expect(search.size).to eq(291)
          expect(search2.size).to eq(291)
          expect(search3.size).to eq(291)
        end
      end
    end

    context "happy sorting_params" do
      it 'should sort coins by name asc' do
        coins = Coin.sorting_params('name')
        sort_coins = Coin.all.order(name: :asc)
        expect(coins.first).to eq(sort_coins.first)
        expect(coins.last).to eq(sort_coins.last)
      end

      it 'should sort coins by symbol asc' do
        coins = Coin.sorting_params('symbol')
        sort_coins = Coin.all.order(symbol: :asc)
        expect(coins.first).to eq(sort_coins.first)
        expect(coins.last).to eq(sort_coins.last)
      end

      it 'should sort coins by usd_price desc' do
        coins = Coin.sorting_params('usd_price')
        sort_coins = Coin.all.order(usd_price: :desc)
        expect(coins.first).to eq(sort_coins.first)
        expect(coins.last).to eq(sort_coins.last)
      end

      it 'should sort coins by btc_price desc' do
        coins = Coin.sorting_params('btc_price')
        sort_coins = Coin.all.order(btc_price: :desc)
        expect(coins.first).to eq(sort_coins.first)
        expect(coins.last).to eq(sort_coins.last)
      end
    end

    context "sad path and edge case sorting_parms" do
      it 'should be case insensitive' do
        name_sort = Coin.all.order(name: :asc)
        symbol_sort = Coin.all.order(symbol: :asc)
        usd_sort = Coin.all.order(usd_price: :desc)
        btc_sort = Coin.all.order(btc_price: :desc)
        percent_sort = Coin.all.order(percent_change: :desc)

        test = Coin.sorting_params('NaMe')
        test2 = Coin.sorting_params('sYmboL')
        test3 = Coin.sorting_params('usD_PriCe')
        test4 = Coin.sorting_params('bTc_PriCe')
        test5 = Coin.sorting_params('pErcENt_ChanGE')

        expect(test.first).to eq(name_sort.first)
        expect(test2.first).to eq(symbol_sort.first)
        expect(test3.first).to eq(usd_sort.first)
        expect(test4.first).to eq(btc_sort.first)
        expect(test5.first).to eq(percent_sort.first)
      end

      it 'should default to sorting by name if params is invalid' do
        sort_coins = Coin.all.order(name: :asc)
        test = Coin.sorting_params('')
        test2 = Coin.sorting_params('🦖')
        test3 = Coin.sorting_params('fdsafdsa')
        test4 = Coin.sorting_params(432432)

        expect(test.first).to eq(sort_coins.first)
        expect(test2.first).to eq(sort_coins.first)
        expect(test3.first).to eq(sort_coins.first)
        expect(test4.first).to eq(sort_coins.first)
      end
    end
  end
end
